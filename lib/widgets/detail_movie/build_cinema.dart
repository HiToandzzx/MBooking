import 'package:flutter/material.dart';

class CinemaItem extends StatefulWidget {
  final String cinemaName;
  final String cinemaDetails;
  final IconData icon;
  final Color backgroundColor;

  const CinemaItem({
    required this.cinemaName,
    required this.cinemaDetails,
    required this.icon,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  CinemaItemState createState() => CinemaItemState();
}

class CinemaItemState extends State<CinemaItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isSelected ? Colors.amber.withOpacity(0.1) : widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isSelected ? Colors.amber : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cinemaName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.cinemaDetails,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              widget.icon,
              size: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
