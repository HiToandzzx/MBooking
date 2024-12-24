import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/view/auth/signin/view_signin.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/basic_text_field.dart';
import '../../../view_model/viewmodel_user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _viewModel = UserViewModel();

  StreamSubscription<String?>? _successSubscription;
  StreamSubscription<String?>? _errorSubscription;

  @override
  void dispose() {
    _successSubscription?.cancel();
    _errorSubscription?.cancel();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _viewModel.dispose();
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
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber
                      ),
                    ),

                    const SizedBox(height: 40,),

                    // USERNAME
                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return CustomTextField(
                          controller: _usernameController,
                          labelText: 'Username',
                          errorText: errors != null && errors.containsKey('username') ? errors['username']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20,),

                    // EMAIL
                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          errorText: errors != null && errors.containsKey('email') ? errors['email']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20,),

                    // PASSWORD
                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          obscureText: true,
                          errorText: errors != null && errors.containsKey('password') ? errors['password']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20,),

                    // CONFIRM PASSWORD
                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return CustomTextField(
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
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

                        await _viewModel.signUp(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
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
                          : const Text('Sign Up'),
                    ),

                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Got an account?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) => const SignInPage(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber
                              ),
                            )
                        ),
                      ],
                    ),
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
