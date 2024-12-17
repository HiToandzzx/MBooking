import 'package:flutter/material.dart';

class OverviewText extends StatefulWidget {
  final String text;

  const OverviewText({Key? key, required this.text}) : super(key: key);

  @override
  OverviewTextState createState() => OverviewTextState();
}

class OverviewTextState extends State<OverviewText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(fontSize: 18),
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (widget.text.length > 100)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Hide' : 'See more',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
