import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/repository.dart';
import '../../register.dart';
import 'scren.dart';

class UserCodePage extends StatelessWidget {
  final String userCode;
  final String deviceCode;
  final String clientId;
  final String clientSecret;

  const UserCodePage({
    required this.clientId,
    required this.clientSecret,
    required this.deviceCode,
    required this.userCode,
    Key? key,
  }) : super(key: key);

  static Route route({
    required String deviceCode,
    required String userCode,
    required String clientId,
    required String clientSecret,
  }) =>
      MaterialPageRoute<void>(
        builder: (_) => UserCodePage(
          clientId: clientId,
          clientSecret: clientSecret,
          deviceCode: deviceCode,
          userCode: userCode,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCodeCubit(
        clientId: clientId,
        clientSecret: clientSecret,
        deviceCode: deviceCode,
        allegroApiRepository: AllegroAuthorizationRepository(),
        userRepository: context.read<UserRepository>(),
      )..getAccessToken(),
      child: UserCodeScreen(userCode: userCode),
    );
  }
}
