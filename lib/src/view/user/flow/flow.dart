import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/repository.dart';
import '../../loading/loading.dart';
import '../user.dart';

class UserFlow extends StatelessWidget {
  const UserFlow({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: UserFlow());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(
        userId: context.read<AuthenticationRepository>().currentUserId,
      ),
      child: BlocProvider(
        create: (context) => UserBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return FlowBuilder<bool>(
              state: state.user.isNew,
              onGeneratePages: _onGenerateUserFlow,
            );
          },
        ),
      ),
    );
  }

  List<Page> _onGenerateUserFlow(
    bool isNew,
    List<Page<dynamic>> pages,
  ) {
    if (isNew) return [IdSecretPage.page()];
    return [LoadingFlow.page()];
  }
}
