import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/auth_ui/login/login_screen.dart';
import 'package:flutter_ecommerce/screens/auth_ui/sign_up/signup_screen.dart';
import 'package:flutter_ecommerce/screens/auth_ui/welcome/welcom_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
