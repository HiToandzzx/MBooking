import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/view/auth/forget_password/view_new_password.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import '../../../helper/count_down.dart';
import '../../../view_model/viewmodel_user.dart';
import '../../../widgets/otp_text_field.dart';

class OTPRequestPage extends StatefulWidget {
  final String email;

  const OTPRequestPage({super.key, required this.email});

  @override
  State<OTPRequestPage> createState() => _OTPRequestPageState();
}

class _OTPRequestPageState extends State<OTPRequestPage> {
  final _otpController = List.generate(6, (_) => TextEditingController());
  final _viewModel = UserViewModel();

  StreamSubscription<String?>? _successSubscription;
  StreamSubscription<String?>? _errorSubscription;

  @override
  void dispose() {
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
                      'Submit OTP from Email',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber
                      ),
                    ),

                    const SizedBox(height: 40),

                    // OTP
                    StreamBuilder<Map<String, List<String>>?>(
                      stream: _viewModel.detailedErrors,
                      builder: (context, snapshot) {
                        final errors = snapshot.data;
                        return OTPInputField(
                          controllers: _otpController,
                          onCompleted: (otp) {
                          },
                          errorText: errors != null && errors.containsKey('code') ? errors['code']?.join(', ') : null,
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CountdownTimer(
                            duration: const Duration(minutes: 10),
                            onTimerComplete: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BUTTON LOGIN
                    MainButton(
                      onPressed: () async {
                        _successSubscription?.cancel();
                        _errorSubscription?.cancel();

                        int otp = int.tryParse(_otpController.map((e) => e.text).join()) ?? 0;

                        await _viewModel.requestOTP(
                            widget.email,
                            otp
                        );

                        _successSubscription = _viewModel.successMessage.listen((message) {
                          if (message != null) {
                            successSnackBar(context: context, message: message);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPasswordRequestPage(
                                  email: widget.email,
                                  otp: otp,
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
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text('Continue'),
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

