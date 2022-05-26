import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../config/app_flow.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: context.select((UserBloc bloc) => bloc.state.user.isNew),
      onGeneratePages: onGenerateNewUserFlow,
    );
  }
}
