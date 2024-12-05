import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:movies_app_ttcn/widgets/connect_firebase.dart';
import 'package:movies_app_ttcn/view/bot_nav.dart';
import '../../widgets/app_vector.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "Error",
      connectingMessage: "Connecting...",
      builder: (context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirebaseAuthPage(),
      ),
    );
  }
}

class FirebaseAuthPage extends StatelessWidget {
  const FirebaseAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return SignInScreen(
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SvgPicture.asset(
                  AppVector.logo,
                ),
              );

            },
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId: "217942102814-i27d2b25u4hs1011pklilg3fiu59gq76.apps.googleusercontent.com"
              ),
              PhoneProviderConfiguration(),
            ],
          );
        }
        return const BotNav();
      },
    );
  }
}


