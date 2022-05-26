import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'id_secret_state.dart';

class IdSecretCubit extends Cubit<IdSecretState> {
  IdSecretCubit() : super(IdSecretInitial());
}
