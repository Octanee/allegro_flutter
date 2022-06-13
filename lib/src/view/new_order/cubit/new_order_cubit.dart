import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../input/input.dart';
import '../../../input/phone.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../../utils/custom_id.dart';

part 'new_order_state.dart';

class NewOrderCubit extends Cubit<NewOrderState> {
  final AllegroOfferRepository _allegroOfferRepository;
  final ProductRepository _productRepository;
  final OrdersRepository _ordersRepository;

  NewOrderCubit({
    required AllegroOfferRepository allegroOfferRepository,
    required ProductRepository productRepository,
    required OrdersRepository ordersRepository,
  })  : _allegroOfferRepository = allegroOfferRepository,
        _productRepository = productRepository,
        _ordersRepository = ordersRepository,
        super(const NewOrderState());

  void addItem({required OrderItem item}) {
    final list = List<OrderItem>.from(state.items);
    list.add(item);
    emit(state.copyWith(items: list));
  }

  void updateItem({required OrderItem item}) {
    final list = List<OrderItem>.from(state.items);
    if (item.quantity == 0) {
      list.removeWhere((element) => element.productId == item.productId);
    } else {
      list[list.indexWhere((element) => element.productId == item.productId)] =
          item;
    }
    emit(state.copyWith(items: list));
  }

  void delivererChange(OrderDeliverer deliverer) {
    emit(state.copyWith(deliverer: deliverer));
  }

  void statusChange(OrderStatus status) {
    emit(state.copyWith(status: status));
  }

  void platformChange(OrderPlatform platform) {
    emit(state.copyWith(platform: platform));
  }

  void nameChanged(String value) {
    final name = TextInput.dirty(value);
    emit(
      state.copyWith(
        name: name,
        formzStatus: Formz.validate(
          [name, state.email, state.phone, state.address],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        formzStatus: Formz.validate(
          [state.name, email, state.phone, state.address],
        ),
      ),
    );
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(
      state.copyWith(
        phone: phone,
        formzStatus: Formz.validate(
          [state.name, state.email, phone, state.address],
        ),
      ),
    );
  }

  void addressChanged(String value) {
    final address = TextInput.dirty(value);
    emit(
      state.copyWith(
        address: address,
        formzStatus: Formz.validate(
          [state.name, state.email, state.phone, address],
        ),
      ),
    );
  }

  void validate() {
    emit(
      state.copyWith(
        formzStatus: Formz.validate(
          [state.name, state.email, state.phone, state.address],
        ),
      ),
    );
  }

  Future<void> saveOrder() async {
    if (state.formzStatus.isInvalid) return;
    try {
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));

      final updateAllegro = await _updateAllegroOffer();
      if (updateAllegro != null) {
        emit(
          state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: updateAllegro,
          ),
        );
        return;
      }

      await _updateFirebaseProducts();

      await _addOrderToFirebase();

      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void newOrder() {
    emit(const NewOrderState());
  }

  void reset() {
    emit(NewOrderState(items: state.items));
  }

  Order _getOrder() {
    return Order(
      id: generateCustomId(),
      items: state.items,
      occurredAt: DateTime.now(),
      lastUpdate: DateTime.now(),
      deliverer: state.deliverer,
      status: state.status,
      platform: state.platform,
      customer: _getCustomer(),
    );
  }

  Customer _getCustomer() {
    return Customer(
      name: state.name.value,
      email: state.email.value,
      phone: state.phone.value,
      address: state.address.value,
    );
  }

  Future<String?> _updateAllegroOffer() async {
    for (var item in state.items) {
      final product =
          await _productRepository.getProductOfId(id: item.productId);

      if (item.quantity != product.quantity) {
        final success = await _allegroOfferRepository
            .updateQuantity(id: [product.allegroId], value: item.quantity);

        if (success != null) {
          return success;
        }
      } else {
        await _allegroOfferRepository.endOffer(id: product.allegroId);
      }
    }
    return null;
  }

  Future<void> _updateFirebaseProducts() async {
    for (var item in state.items) {
      final product =
          await _productRepository.getProductOfId(id: item.productId);
      final quantity = product.quantity - item.quantity;
      await _productRepository.updateProductQuantity(
        id: item.productId,
        quantity: quantity,
        isActive: quantity > 0 ? true : false,
      );
    }
  }

  Future<void> _addOrderToFirebase() async {
    final order = _getOrder();

    await _ordersRepository.updateOrder(order);
  }
}
