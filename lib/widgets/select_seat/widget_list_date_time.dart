import 'package:flutter/material.dart';
import '../../model/seat_model.dart';

Widget buildDateList(Showtime showtime, String selectedDate, Function(String) onDateSelected) {
  final dayParts = showtime.day!.split(' '); // Assuming format is "10 Dec"
  final day = dayParts[0];
  final month = dayParts[1];

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 1,
    itemBuilder: (context, index) {
      final isSelected = selectedDate == showtime.day;

      return GestureDetector(
        onTap: () => onDateSelected(showtime.day!),
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.amber : const Color(0xFF303030).withOpacity(0.7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    month,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isSelected ? Colors.grey.shade400 : const Color(0xFFF5F5F5).withOpacity(0.7),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildTimeList(Showtime showtime, String selectedTime, Function(String) onTimeSelected) {

  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 1, // Only one showtime object
      itemBuilder: (context, index) {
        final isSelected = selectedTime == showtime.startTime;

        return GestureDetector(
          onTap: () => onTimeSelected(showtime.startTime!),
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber : const Color(0xFF303030).withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      showtime.startTime!,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      })   ;
}
