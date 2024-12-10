import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helper/nav_mess_profile.dart';
import '../../widgets/basic_button.dart';
import '../../widgets/basic_text_field.dart';

class ChangePasswordPage extends StatefulWidget {

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  Future<void> _reauthenticateUser(String currentPassword) async {
    try {
      // Credential for reauthentication
      AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: currentPassword
      );

      // Reauthenticate user
      await user!.reauthenticateWithCredential(credential);
    } catch (e) {
      throw 'Current password is incorrect';
    }
  }

  Future<void> _changePassword(String newPassword) async {
    try {
      await user!.updatePassword(newPassword);
      showTrueSnackBar(context, 'Password updated successfully');
    } catch (e) {
      showFalseSnackBar(context, 'Failed to update password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // Current password
            CustomTextField(
              controller: _currentPasswordController,
              labelText: 'Current password',
              obscureText: true,  // Hide password input
            ),

            const SizedBox(height: 20),

            // New password
            CustomTextField(
              controller: _newPasswordController,
              labelText: 'New password',
              obscureText: true,  // Hide password input
            ),

            const SizedBox(height: 20),

            // Confirm password
            CustomTextField(
              controller: _confirmPasswordController,
              labelText: 'Confirm password',
              obscureText: true,  // Hide password input
            ),

            const SizedBox(height: 20),

            BasicAppButton(
              onPressed: () async {
                try {
                  if (user != null) {
                    String currentPassword = _currentPasswordController.text.trim();
                    String newPassword = _newPasswordController.text.trim();
                    String confirmPassword = _confirmPasswordController.text.trim();

                    // Nếu current password đúng
                    await _reauthenticateUser(currentPassword);

                    // Nếu new password = confirm password
                    if (newPassword != confirmPassword) {
                      showFalseSnackBar(context, 'New password and confirm password do not match');
                      return;
                    }

                    // Nếu new password < 6
                    if (newPassword.length < 6) {
                      showFalseSnackBar(context, 'Password should be at least 6 characters');
                      return;
                    }

                    await _changePassword(newPassword);
                  } else {
                    showTrueSnackBar(context, 'No user signed in');
                  }
                } catch (e) {
                  showFalseSnackBar(context, 'Failed to update password: $e');
                }
              },
              title: 'Change password',
            ),
          ],
        ),
      ),
    );
  }
}
