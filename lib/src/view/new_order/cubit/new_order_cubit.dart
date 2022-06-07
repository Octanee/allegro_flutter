import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../input/input.dart';
import '../../../input/phone.dart';
import '../../../models/models.dart';

part 'new_order_state.dart';

class NewOrderCubit extends Cubit<NewOrderState> {
  NewOrderCubit() : super(const NewOrderState());

  void addItem({required OrderItem item}) {
    final list = List<OrderItem>.from(state.items);
    list.add(item);
    emit(state.copyWith(items: list));
  }
}
