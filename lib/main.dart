import 'package:flutter/material.dart';
import 'views/auth/login_view.dart';
import 'app/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acil Alalım',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const LoginView(),
    );
  }
}
