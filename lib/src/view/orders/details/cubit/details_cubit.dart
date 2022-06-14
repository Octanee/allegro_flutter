import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({required Order order}) : super(DetailsState(order: order));

  void updateOrder({required Order order}) {
    emit(state.copyWith(order: order, updated: true));
  }
}
