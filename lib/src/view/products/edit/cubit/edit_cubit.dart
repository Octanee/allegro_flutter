import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../exceptions/exceptions.dart';
import '../../../../input/input.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final ProductRepository _productRepository;
  final AllegroOfferRepository _allegroOfferRepository;

  EditCubit({
    required Product product,
    required AllegroOfferRepository allegroOfferRepository,
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        _allegroOfferRepository = allegroOfferRepository,
        super(EditState(product: product));

  void init() {
    final purchace = Price.dirty(state.product.purchasePrice ?? 0.00);
    final allegro = Price.dirty(state.product.allegroPrice);
    final quantity = Quantity.dirty(state.product.quantity);

    emit(
      state.copyWith(
        purchasePrice: purchace,
        allegroPrice: allegro,
        quantity: quantity,
        status: Formz.validate([purchace, allegro, quantity]),
      ),
    );
  }

  void purchasePriceChanged({required double value}) {
    final price = Price.dirty(value);
    emit(
      state.copyWith(
        purchasePrice: price,
        status: Formz.validate([
          price,
          state.allegroPrice,
          state.quantity,
        ]),
      ),
    );
  }

  void allegroPriceChanged({required double value}) {
    final price = Price.dirty(value);
    emit(
      state.copyWith(
        allegroPrice: price,
        status: Formz.validate([
          state.purchasePrice,
          price,
          state.quantity,
        ]),
      ),
    );
  }

  void quantityChanged({required int value}) {
    final quantity = Quantity.dirty(value);
    emit(
      state.copyWith(
        quantity: quantity,
        status: Formz.validate([
          state.purchasePrice,
          state.purchasePrice,
          quantity,
        ]),
      ),
    );
  }

  Future<void> updateProduct() async {
    try {
      if (!state.status.isValidated) return;
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final product = state.product.copyWith(
        allegroPrice: state.allegroPrice.value,
        purchasePrice: state.purchasePrice.value,
        quantity: state.quantity.value,
      );

      await _allegroOfferRepository.updateOffer(
        id: product.allegroId,
        data: product.toAllegro(),
      );
      await _productRepository.updateProduct(product: product);

      emit(
        state.copyWith(
          product: product,
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on AllegroApiException catch (e) {
      log('$runtimeType => $e');
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
