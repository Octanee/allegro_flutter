import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/allegro_api/allegro_api.dart';
import '../../../extensions/extension.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';

part 'synchronization_state.dart';

class SynchronizationCubit extends Cubit<SynchronizationState> {
  final AllegroOfferRepository _allegroOfferRepository;
  final ProductRepository _productRepository;

  SynchronizationCubit({
    required AllegroOfferRepository allegroOfferRepository,
    required ProductRepository productRepository,
  })  : _allegroOfferRepository = allegroOfferRepository,
        _productRepository = productRepository,
        super(const SynchronizationState());

  Future<void> loadOffers() async {
    emit(state.copyWith(status: SynchronizationStatus.offersLoading));
    try {
      final offers = await _allegroOfferRepository.getSellersOffers();
      emit(
        state.copyWith(
          offers: offers,
          status: SynchronizationStatus.offersLoadded,
        ),
      );
    } on AllegroApiException catch (e) {
      emit(
        state.copyWith(
          status: SynchronizationStatus.error,
          errorMessage: 'Error ${e.code}: ${e.message}',
        ),
      );
    }
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(status: SynchronizationStatus.productsLoading));
    try {
      final products = await _productRepository.getProducts();
      emit(
        state.copyWith(
          products: products,
          status: SynchronizationStatus.productsLoadded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SynchronizationStatus.error,
          errorMessage: 'Error -> loadProducts',
        ),
      );
    }
  }

  Future<void> checkProducts() async {
    final list = <Product>[];
    for (var i = 0; i < state.offers.length; i++) {
      emit(
        state.copyWith(
          status: SynchronizationStatus.checkingProducts,
          index: i + 1,
        ),
      );

      final offer = state.offers[i];

      var product = state.products.firstWhere(
        (product) => product.allegroId == offer.id,
        orElse: () => Product(
          id: _generateProductId(),
          allegroId: offer.id,
          name: offer.name,
          allegroPrice: offer.price,
          quantity: offer.available,
          imageUrl: offer.primaryImage,
        ),
      );

      if (product.allegroPrice != offer.price ||
          product.quantity != offer.available) {
        product = product.copyWith(
          allegroPrice: offer.price,
          quantity: offer.available,
        );
      }
      list.add(product);
    }
    emit(
      state.copyWith(
        status: SynchronizationStatus.checkingCompleted,
        updateNeeded: list,
      ),
    );
  }

  String _generateProductId() {
    final value = Random().nextString(6);
    final result = '${value.substring(0, 3)}-${value.substring(3, 6)}';
    return result;
  }

  Future<void> updateProducts() async {
    try {
      for (var i = 0; i < state.updateNeeded.length; i++) {
        final product = state.updateNeeded[i];
        emit(
          state.copyWith(
            status: SynchronizationStatus.updating,
            index: i + 1,
          ),
        );
        _productRepository.updateProduct(product: product);
      }
      emit(state.copyWith(status: SynchronizationStatus.completed));
    } catch (e) {
      emit(
        state.copyWith(
          status: SynchronizationStatus.error,
          errorMessage: 'Error => updateProducts',
        ),
      );
    }
  }
}
