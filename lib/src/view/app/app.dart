import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../auth/auth.dart';

class DecorApp extends StatelessWidget {
  const DecorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(
        seedColor: Colors.brown,
        brightness: Brightness.light,
      ),
      home: const AuthFlow(),
    );
  }
}
