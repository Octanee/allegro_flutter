import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/custom_bloc_observer.dart';
import 'src/config/firebase_options.dart';
import 'src/repository/authentication.dart';
import 'src/view/app/app.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    blocObserver: CustomBlocObserver(),
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.userId.first;

      runApp(DecorApp(authenticationRepository: authenticationRepository));
    },
  );
}
