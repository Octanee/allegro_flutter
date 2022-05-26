import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_code.dart';
import 'widgets/widgets.dart';

class UserCodeScreen extends StatelessWidget {
  final String userCode;
  const UserCodeScreen({required this.userCode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCodeCubit, UserCodeState>(
      listener: (context, state) {
        if(state.status == UserCodeStatus.complete){
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserCodeText(userCode: userCode),
              const UrlText(
                url:
                    'allegro.pl.allegrosandbox.pl/uzytkownik/bezpieczenstwo/skojarz-aplikacje',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
