import 'package:flutter/material.dart';

class StoryLineText extends StatefulWidget {
  final String text;

  const StoryLineText({Key? key, required this.text}) : super(key: key);

  @override
  StoryLineTextState createState() => StoryLineTextState();
}

class StoryLineTextState extends State<StoryLineText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
              fontSize: 18,
            color: Colors.grey
          ),
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
