import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/bot_nav.dart';
import 'package:movies_app_ttcn/view/welcome/view_welcome.dart';
import 'view/auth/signin/model_user.dart';
import 'view/auth/signin/viewmodel_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  User? currentUser = await SignInViewModel().getCurrentUser();

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

        // DISABLE ANIMATION
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: initialUser != null ? const BotNav() : const WelcomePage(),
    );
  }
}

