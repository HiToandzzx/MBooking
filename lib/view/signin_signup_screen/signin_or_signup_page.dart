import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_ttcn/view/firebase_auth/firebase_auth.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/carousel_movies_login_page.dart';

class SignInOrSignUpPage extends StatelessWidget {
  const SignInOrSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppVector.logo,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: LoginMoviesCarousel(),
            ),

            const SizedBox(height: 30,),

            const Text(
              'MBooking hello!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20,),

            const Text(
              'Enjoy your favorite movies',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 70,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirebaseAuthPage(),
                        )
                    );
                  },
                  title: 'Sign in or sign up'
              ),
            ),

            const SizedBox(height: 25,),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'By sign in or sign up, you agree to our Terms of Service and Privac y Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
