import 'package:flutter/material.dart';

void showTrueSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        text,
        style: const TextStyle(
            color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ), // Màu chữ
      ),
      backgroundColor: Colors.green[200], // Màu nền của SnackBar
    ),
  );
}

void showFalseSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        text,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ), // Màu chữ
      ),
      backgroundColor: Colors.red[200], // Màu nền của SnackBar
    ),
  );
}

