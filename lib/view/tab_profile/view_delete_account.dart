import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/welcome/view_welcome.dart';

Future<void> showDeleteConfirmationDialog(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.amber[100],
        title: const Text(
            'Confirm Deletion',
          style: TextStyle(
              color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        content: const Text(
            'Are you sure to delete your account?',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
                'Cancel',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              User? user = auth.currentUser;
              if (user != null) {
                await user.delete();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomePage(),
                    )
                );
              }
            },
            child: const Text(
                'Delete',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
          ),
        ],
      );
    },
  );
}