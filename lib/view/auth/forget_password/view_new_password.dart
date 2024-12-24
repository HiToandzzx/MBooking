import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/view/auth/signin/view_signin.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/basic_text_field.dart';
import '../../../view_model/viewmodel_user.dart';

class NewPasswordRequestPage extends StatefulWidget {
  final String email;
  final int otp;

  const NewPasswordRequestPage({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<NewPasswordRequestPage> createState() => _NewPasswordRequestPageState();
}


class _NewPasswordRequestPageState extends State<NewPasswordRequestPage> {
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _viewModel = UserViewModel();

  StreamSubscription<String?>? _successSubscription;
  StreamSubscription<String?>? _errorSubscription;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _viewModel.dispose();
    _successSubscription?.cancel();
    _errorSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppVector.logo,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
        stream: _viewModel.isLoading,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New Password',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber
                      ),
                    ),
                    const SizedBox(height: 40,),

                    // EMAIL
                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return CustomTextField(
                          controller: _newPasswordController,
                          labelText: 'New Password',
                          obscureText: true,
                          errorText: errors != null && errors.containsKey('password') ? errors['password']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20,),

                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return CustomTextField(
                          controller: _confirmNewPasswordController,
                          labelText: 'Confirm New Password',
                          obscureText: true,
                          errorText: errors != null && errors.containsKey('password_confirmation') ? errors['password_confirmation']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20,),

                    // BUTTON LOGIN
                    MainButton(
                      onPressed: () async {
                        _successSubscription?.cancel();
                        _errorSubscription?.cancel();

                        await _viewModel.resetPassword(
                          widget.email,
                          widget.otp,
                          _newPasswordController.text,
                          _confirmNewPasswordController.text,
                        );

                        _successSubscription = _viewModel.successMessage.listen((message) {
                          if (message != null) {
                            successSnackBar(context: context, message: message);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          }
                        });

                        _errorSubscription = _viewModel.errorMessage.listen((message) {
                          if (message != null) {
                            failedSnackBar(context: context, message: message);
                          }
                        });
                      },
                      title: isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text('Submit'),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
