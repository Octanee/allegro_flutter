import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/view/app/app.dart';
import 'src/config/config.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    blocObserver: CustomBlocObserver(),
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const DecorApp());
    },
  );
}
