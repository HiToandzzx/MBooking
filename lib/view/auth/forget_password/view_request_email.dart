import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/view/auth/forget_password/view_request_otp.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/basic_text_field.dart';
import '../../../view_model/viewmodel_user.dart';

class EmailRequestPage extends StatefulWidget {
  const EmailRequestPage({super.key});

  @override
  State<EmailRequestPage> createState() => _EmailRequestPageState();
}

class _EmailRequestPageState extends State<EmailRequestPage> {
  final _emailController = TextEditingController();
  final _viewModel = UserViewModel();

  StreamSubscription<String?>? _successSubscription;
  StreamSubscription<String?>? _errorSubscription;

  @override
  void dispose() {
    _emailController.dispose();
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
                      'Forget Password',
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
                          controller: _emailController,
                          labelText: 'Email',
                          errorText: errors != null && errors.containsKey('email') ? errors['email']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20,),

                    // BUTTON LOGIN
                    MainButton(
                      onPressed: () async {
                        _successSubscription?.cancel();
                        _errorSubscription?.cancel();

                        await _viewModel.requestEmail(
                          _emailController.text,
                        );

                        _successSubscription = _viewModel.successMessage.listen((message) {
                          if (message != null) {
                            successSnackBar(context: context, message: message);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPRequestPage(
                                  email: _emailController.text,
                                ),
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
                          ? const CircularProgressIndicator(color: Colors.black,)
                          : const Text('Request'),
                    ),

                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Back to',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
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
                        )
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
