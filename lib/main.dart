import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/bot_nav.dart';
import 'package:movies_app_ttcn/view/signin_signup/signin_or_signup_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          background: Colors.black54,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Satoshi',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black54
        ),

        // DISABLE ANIMATION
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: user == null ? const SignInOrSignUpPage() : const BotNav(),
    );
  }
}

