import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exceptions/allegro_api/allegro_api.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final AllegroOfferRepository _allegroOfferRepository;

  ListCubit({
    required AllegroOfferRepository allegroOfferRepository,
  })  : _allegroOfferRepository = allegroOfferRepository,
        super(const ListState());

  Future<void> loadAllegroOffers() async {
    try {
      emit(state.copyWith(status: ListStatus.loading));

      final list = await _allegroOfferRepository.getSellersOffers();

      emit(state.copyWith(status: ListStatus.loaded, offers: list));
    } on AllegroApiException catch (e) {
      emit(
        state.copyWith(
          status: ListStatus.error,
          errorMessage: 'ERROR ${e.code}: ${e.message}',
        ),
      );
    }
  }
}
