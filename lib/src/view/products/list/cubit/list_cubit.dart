import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../../../../repository/repository.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final ProductRepository _productRepository;

  ListCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ListState());

  Future<void> loadProducts() async {
    try {
      emit(state.copyWith(status: ListStatus.loading));

      final list = await _productRepository.products;

      emit(state.copyWith(status: ListStatus.loaded, products: list));
    } catch (e) {
      emit(
        state.copyWith(
          status: ListStatus.error,
          errorMessage: 'Error => loadProducts {$e}',
        ),
      );
    }
  }
}
