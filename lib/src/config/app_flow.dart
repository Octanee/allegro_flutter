import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../view/home/home.dart';
import '../view/loading/loading.dart';
import '../view/login/view/page.dart';
import '../view/register/register.dart';
import '../view/register/view/pages/client_id_secret_page.dart';
import '../view/register/view/pages/user_code_page.dart';

List<Page> onGenerateAuthFlow(
  AuthStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AuthStatus.authenticated:
      return [LoadingPage.page()];
    case AuthStatus.unauthenticated:
      return [LoginPage.page()];
  }
}

List<Page> onGenerateNewUserFlow(
  bool isNew,
  List<Page<dynamic>> pages,
) {
  if (isNew) return [RegisterPage.page()];
  return [HomePage.page()];
}

List<Page> onGenerateRegisterFlow(
  RegisterStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case RegisterStatus.auth:
      return [ClientIdSecretPage.page()];
    case RegisterStatus.token:
      return [UserCodePage.page()];
  }
}
