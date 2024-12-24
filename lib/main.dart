import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/bot_nav/bot_nav.dart';
import 'package:movies_app_ttcn/view/welcome/view_welcome.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'model/model_user.dart';
import 'view_model/viewmodel_user.dart';

void main() async {
  Stripe.publishableKey = 'pk_test_51NnANvICFXSh1wtRd0oyTnWdPyPnv5RFYePJktzqAVwff8LpMAUr1XOfXV8cIM3Uoxi5IsbIUUAJw1YVMYTFpUov006DzGLZ6A'; // Publishable Key từ Stripe
  WidgetsFlutterBinding.ensureInitialized();

  User? currentUser = await UserViewModel().getCurrentUser();

  runApp(MyApp(initialUser: currentUser));
}

class MyApp extends StatelessWidget {
  final User? initialUser;

  const MyApp({Key? key, this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

        // MÀU CON TRỎ TRONG TEXT FIELD
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),

        // DISABLE ANIMATION
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: initialUser != null ? const BotNav() : const WelcomePage(),
    );
  }
}

