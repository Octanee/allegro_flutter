import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../../../../input/input.dart';
import '../../../../models/models.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit({required Order order}) : super(EditState(order: order));

  void init() {
    final order = state.order;

    final name = TextInput.dirty(order.customer.name);
    final email = Email.dirty(order.customer.email);
    final phone = Phone.dirty(order.customer.phone);
    final address = TextInput.dirty(order.customer.address);

    emit(
      state.copyWith(
        email: email,
        name: name,
        phone: phone,
        address: address,
        items: order.items,
        deliverer: order.deliverer,
        status: order.status,
        platform: order.platform,
        price: order.price,
        formzStatus: Formz.validate([email, name, phone, address]),
      ),
    );
  }

  void addItem({required OrderItem item}) {
    final list = List<OrderItem>.from(state.items);
    list.add(item);

    final price = _calculatePrice(list);
    emit(state.copyWith(items: list, price: price));
  }

  void updateItem({required OrderItem item}) {
    final list = List<OrderItem>.from(state.items);
    if (item.quantity == 0) {
      list.removeWhere((element) => element.productId == item.productId);
    } else {
      list[list.indexWhere((element) => element.productId == item.productId)] =
          item;
    }

    final price = _calculatePrice(list);
    emit(state.copyWith(items: list, price: price));
  }

  double _calculatePrice(List<OrderItem> list) {
    final price = list
        .fold<double>(
          0,
          (previous, element) => previous + (element.price * element.quantity),
        )
        .toPrice();
    log('EditCubit => _calculatePrice { price: $price }');
    return price;
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
}
