import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*FutureBuilder<String?>(
            future: user?.getIdToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              } else if (snapshot.hasError) {
                return const Text(
                  "Error loading token",
                  style: TextStyle(color: Colors.red),
                );
              } else {
                final token = snapshot.data ?? "No Token";
                return Text(
                  "Token: $token",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                );
              }
            },
          ),*/

            ElevatedButton(
                onPressed: () async {
                  // Sign out from Firebase
                  await FirebaseAuth.instance.signOut();
                  // Sign out from Google
                  await GoogleSignIn().signOut();
                },
                child: const Text('Logout')
            )
          ],
        )
    );
  }
}
