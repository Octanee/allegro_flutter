import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../config/app_flow.dart';
import '../../theme/theme.dart';

class DecorAppScreen extends StatelessWidget {
  const DecorAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(
        seedColor: Colors.brown,
        brightness: Brightness.light,
      ),
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAuthFlow,
      ),
    );
  }
}
