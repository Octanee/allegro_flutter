import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({required Product product})
      : super(DetailsState(product: product));

  void updateProduct({required Product product}) {
    emit(state.copyWith(product: product, updated: true));
  }
}
