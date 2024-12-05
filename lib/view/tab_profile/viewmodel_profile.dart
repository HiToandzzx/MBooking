import 'package:flutter/material.dart';

Widget buildListTile({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
  required bool isLastItem,
}) {
  return Container(
    decoration: BoxDecoration(
      border: isLastItem
          ? null
          : const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
    ),
    child: ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white),
      onTap: onTap,
    ),
  );
}