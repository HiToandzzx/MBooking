import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/seat_model.dart';

class SeatLegend extends StatelessWidget {
  final Color color;
  final String label;

  const SeatLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatWidget({Key? key, required this.seat, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Xác định màu sắc của ghế
    Color color;
    if (seat.isSelected) {
      color = Colors.yellow; // Ghế được chọn
    } else if (seat.isReserved) {
      color = Colors.grey[600]!; // Ghế đã đặt
    } else {
      color = Colors.grey[800]!; // Ghế còn trống
    }

    return GestureDetector(
      onTap: seat.isReserved ? null : onTap, // Chỉ cho phép chọn ghế chưa đặt
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '${seat.id}', // Hiển thị ID ghế
            style: TextStyle(
              color: seat.isSelected ? Colors.black : Colors.white,
              fontSize: 14,
              fontWeight: seat.isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}



class DateCircle extends StatelessWidget {
  final String date;
  final bool isSelected;

  const DateCircle({Key? key, required this.date, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: isSelected ? Colors.yellow : Colors.grey[800],
        child: Text(
          date,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  final String time;
  final bool isSelected;

  const TimeChip({Key? key, required this.time, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        label: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? Colors.yellow : Colors.grey[800],
      ),
    );
  }
}