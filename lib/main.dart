import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_ecommerce/firebase_options.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/screens/auth_ui/login/login_screen.dart';
import 'package:flutter_ecommerce/screens/auth_ui/sign_up/signup_screen.dart';
import 'package:flutter_ecommerce/screens/auth_ui/welcome/welcom_screen.dart';
import 'package:flutter_ecommerce/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter_ecommerce/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter_ecommerce/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter E-Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return const HomeScreen();
              return const CustomBottomVar();
            } else {
              return const WelcomScreen();
            }
          },
        ),
        routes: {
          '/welcome': (context) => const WelcomScreen(),
          '/navBar': (context) => const CustomBottomVar(),
          // '/editProfile': (context) => EditProfileScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
