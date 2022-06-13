import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exceptions/allegro_api/allegro_api.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';
import '../../../../utils/custom_id.dart';

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
      final products = await _productRepository.products;
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

      var product = state.products.firstWhereOrNull(
        (product) => product.allegroId == offer.id,
      );

      if (product != null) {
        if (product.name != offer.name ||
            product.allegroPrice != offer.price ||
            product.quantity != offer.available ||
            product.isActive != offer.status) {
          product = product.copyWith(
            name: offer.name,
            allegroPrice: offer.price,
            quantity: offer.available,
            isActive: offer.status,
          );
          list.add(product);
        }
      } else {
        list.add(
          Product(
            id: generateCustomId(),
            allegroId: offer.id,
            name: offer.name,
            isActive: offer.status,
            allegroPrice: offer.price,
            quantity: offer.available,
            imageUrl: offer.primaryImage,
          ),
        );
      }
    }
    emit(
      state.copyWith(
        status: SynchronizationStatus.checkingCompleted,
        updateNeeded: list,
      ),
    );
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
