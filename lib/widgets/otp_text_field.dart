import 'package:flutter/material.dart';

class OTPInputField extends StatefulWidget {
  final List<TextEditingController> controllers;
  final ValueChanged<String>? onCompleted;
  final String? errorText;

  const OTPInputField({
    Key? key,
    required this.controllers,
    this.onCompleted,
    this.errorText,
  }) : super(key: key);

  @override
  OTPInputFieldState createState() => OTPInputFieldState();
}

class OTPInputFieldState extends State<OTPInputField> {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Column(
          children: [
            SizedBox(
              width: 48,
              child: TextField(
                controller: widget.controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index < 5) {
                      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                    } else {
                      FocusScope.of(context).unfocus();
                      final otp = widget.controllers.map((e) => e.text).join();
                      if (widget.onCompleted != null) {
                        widget.onCompleted!(otp);
                      }
                    }
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                  }
                },
              ),
            ),
            if (widget.errorText != null) ...[
              const SizedBox(height: 8),
              Center(
                child: Text(
                  widget.errorText!,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ],
        );
      }),
    );
  }
}