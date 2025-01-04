import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildDetailColumn({
  required String icon,
  required String title,
  required String subtitle,
}) {
  return Row(
    children: [
      SvgPicture.asset(icon),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            width: 100,
            child: Text(
              subtitle,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ),
        ],
      ),
    ],
  );
}