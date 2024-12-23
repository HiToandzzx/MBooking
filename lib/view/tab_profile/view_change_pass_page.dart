import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import '../../view_model/viewmodel_user.dart';
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
  final UserViewModel _userViewModel = UserViewModel();

  StreamSubscription<String?>? _successSubscription;
  StreamSubscription<String?>? _errorSubscription;

  @override
  void dispose() {
    _successSubscription?.cancel();
    _errorSubscription?.cancel();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _userViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
        stream: _userViewModel.isLoading,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Current password
                  StreamBuilder<Map<String, List<String>>?>(
                    stream: _userViewModel.detailedErrors,
                    builder: (context, snapshot) {
                      final errors = snapshot.data;
                      return CustomTextField(
                        controller: _currentPasswordController,
                        labelText: 'Current Password',
                        obscureText: true,
                        errorText: errors != null && errors.containsKey('old_password') ? errors['old_password']?.join(', ') : null,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // New password
                  StreamBuilder<Map<String, List<String>>?>(
                    stream: _userViewModel.detailedErrors,
                    builder: (context, snapshot) {
                      final errors = snapshot.data;
                      return CustomTextField(
                        controller: _newPasswordController,
                        labelText: 'New Password',
                        obscureText: true,
                        errorText: errors != null && errors.containsKey('new_password') ? errors['new_password']?.join(', ') : null,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Confirm password
                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  MainButton(
                    onPressed: () async {
                      _successSubscription?.cancel();
                      _errorSubscription?.cancel();

                      final currentPassword = _currentPasswordController.text;
                      final newPassword = _newPasswordController.text;
                      final confirmPassword = _confirmPasswordController.text;

                      await _userViewModel.changePassword(
                        password: currentPassword,
                        newPassword: newPassword,
                        newPasswordConfirmation: confirmPassword,
                      );

                      _successSubscription = _userViewModel.successMessage.listen((message) {
                        if (message != null) {
                          successSnackBar(context: context, message: message);
                          Navigator.pop(context);
                        }
                      });

                      _errorSubscription = _userViewModel.errorMessage.listen((message) {
                        if (message != null) {
                          failedSnackBar(context: context, message: message);
                        }
                      });
                    },
                    title: isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text('Change Password'),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
