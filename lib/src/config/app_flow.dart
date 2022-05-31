import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../view/view.dart';

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

List<Page> onGenerateUserFlow(
  bool isNew,
  List<Page<dynamic>> pages,
) {
  if (isNew) return [IdSecretPage.page()];
  return [HomePage.page()];
}
