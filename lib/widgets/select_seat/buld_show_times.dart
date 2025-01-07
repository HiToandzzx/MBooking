import 'package:flutter/material.dart';
import '../../helper/format_date.dart';
import '../../model/model_show_time.dart';

class BuildShowTimes extends StatefulWidget {
  final List<DataShowTimes> showTimes;
  final Function(String selectedDate, String selectedTime)? onShowtimeSelected;

  const BuildShowTimes({
    Key? key,
    required this.showTimes,
    this.onShowtimeSelected,
  }) : super(key: key);

  @override
  BuildShowTimesState createState() => BuildShowTimesState();
}

class BuildShowTimesState extends State<BuildShowTimes> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectInitialTime();
  }

  void _selectInitialTime() {
    final uniqueDates = widget.showTimes.map((e) => e.date).toSet().toList();
    if (uniqueDates.isNotEmpty) {
      final filteredTimes = widget.showTimes
          .where((e) => e.date == uniqueDates[selectedDateIndex])
          .map((e) => e.time)
          .toList();

      if (filteredTimes.isNotEmpty) {
        widget.onShowtimeSelected?.call(
          uniqueDates[selectedDateIndex]!,
          filteredTimes[0]!,
        );
      }
    }
  }

  void _onDateSelected(int index) {
    setState(() {
      selectedDateIndex = index;
      selectedTimeIndex = 0;
    });

    final uniqueDates = widget.showTimes.map((e) => e.date).toSet().toList();
    final filteredTimes = widget.showTimes
        .where((e) => e.date == uniqueDates[selectedDateIndex])
        .map((e) => e.time)
        .toList();

    if (filteredTimes.isNotEmpty) {
      widget.onShowtimeSelected?.call(
        uniqueDates[selectedDateIndex]!,
        filteredTimes[0]!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final uniqueDates = widget.showTimes
        .map((e) => e.date)
        .toSet()
        .where((date) {
          final parsedDate = DateTime.tryParse('${date!.substring(6)}-${date.substring(3, 5)}-${date.substring(0, 2)}');
          return parsedDate != null && parsedDate.isAfter(now.subtract(const Duration(days: 1)));
        }).toList();

    if (uniqueDates.isEmpty) {
      return const Center(
        child: Text(
          'No available dates.',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    final filteredTimes = widget.showTimes
        .where((e) => e.date == uniqueDates[selectedDateIndex])
        .map((e) {
          final fullDateTime = DateTime.tryParse('${e.date!.substring(6)}-${e.date?.substring(3, 5)}-${e.date?.substring(0, 2)} ${e.time}');
          if (fullDateTime == null) return null;
          if (fullDateTime.day == now.day && fullDateTime.month == now.month && fullDateTime.year == now.year) {
            return fullDateTime.isAfter(now) ? e.time : null;
          }
          return e.time;
        }).where((time) => time != null).toList();

    if (filteredTimes.isEmpty) {
      return const Center(
        child: Text(
          'No available times for the selected date.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Date Picker
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: uniqueDates.length,
              itemBuilder: (context, index) {
                final isSelected = selectedDateIndex == index;
                final date = uniqueDates[index];
                return GestureDetector(
                  onTap: () => _onDateSelected(index),
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.grey[800],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          formatMonth(date!.substring(3, 5)),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 45,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                          ),
                          child: Text(
                            date.substring(0, 2),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Time Picker
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredTimes.length,
              itemBuilder: (context, index) {
                final isSelected = selectedTimeIndex == index;
                final time = filteredTimes[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeIndex = index;
                      widget.onShowtimeSelected?.call(
                        uniqueDates[selectedDateIndex]!,
                        time!,
                      );
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: isSelected
                        ? BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.amber, width: 2),
                    )
                        : BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        time.toString().substring(0, 5),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
