import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  final double ? height;

  const MainButton({
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
          minimumSize: Size.fromHeight(height ?? 50),
          backgroundColor: Colors.amber[400],
        ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        child: title,
      ),
    );
  }
}

class BasicButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;
  final double ? height;

  const BasicButton({
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
          minimumSize: Size.fromHeight(height ?? 50),
          backgroundColor: Colors.black,
            side: const BorderSide(
                width: 1,
                color: Colors.white
            )
        ),
        child: Text(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            title
        )
    );
  }
}

class DeleteButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;
  final double ? height;

  const DeleteButton({
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
          minimumSize: Size.fromHeight(height ?? 50),
          backgroundColor: Colors.red,
        ),
        child: Text(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            title
        )
    );
  }
}


