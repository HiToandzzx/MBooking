import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;
  final double ? height;

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 56),
          backgroundColor: Colors.amber[400],
        ),
        child: Text(
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            title
        )
    );
  }
}


