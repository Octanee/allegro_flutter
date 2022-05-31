import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../config/app_flow.dart';
import '../../../repository/repository.dart';
import '../cubit/loading_cubit.dart';
import 'screen.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoadingPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(
        userId: context.read<AuthenticationRepository>().currentUserId,
      )..user,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                UserBloc(userRepository: context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => LoadingCubit(
              allegroAuthorizationRepository: AllegroAuthorizationRepository(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.status == UserStatus.loaded) {
              context.read<LoadingCubit>().checkToken();
              return BlocBuilder<LoadingCubit, LoadingState>(
                builder: (context, state) {
                  switch (state.status) {
                    case LoadingStatus.complete:
                      return FlowBuilder(
                        state: context
                            .select((UserBloc bloc) => bloc.state.user.isNew),
                        onGeneratePages: onGenerateUserFlow,
                      );
                    default:
                      return const LoadingScreen();
                  }
                },
              );
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }
}
