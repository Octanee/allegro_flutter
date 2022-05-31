import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingState());

  void token() {
    emit(state.copyWith(status: LoadingStatus.token));
  }

  void synchronization() {
    emit(state.copyWith(status: LoadingStatus.synchronization));
  }

  void complete() {
    emit(state.copyWith(status: LoadingStatus.complete));
  }
}
