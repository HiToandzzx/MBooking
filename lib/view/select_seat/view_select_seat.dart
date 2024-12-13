import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/helper/nav_mess_profile.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';

import '../../widgets/app_images.dart';
import '../../widgets/select_seat/build_list_time.dart';
import '../../widgets/select_seat/buld_list_date.dart';

class SelectSeatPage extends StatefulWidget {
  const SelectSeatPage({super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  final List<String> rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final List<String> cols = ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'];

  final Map<String, Color> seatColors = {
    'available': Colors.grey.withOpacity(0.3),
    'reserved': Colors.amber.withOpacity(0.2),
    'selected': Colors.amber,
  };

  final List<String> reservedSeats = [
    'E4', 'E5', 'E6', 'E7', 'E8', 'E9', 'E10', 'E11', 'E12',
    'F7', 'F8', 'F9', 'F10',
    'D6', 'D7', 'D8', 'D9', 'D10'
  ];

  final List<String> selectedSeats = [];

  void toggleSeatSelection(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Seat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            // SCREEN
            const Image(
                image: AssetImage(AppImages.screen)
            ),

            // SEATS
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols.length,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: rows.length * cols.length,
                itemBuilder: (context, index) {
                  final row = rows[index ~/ cols.length];
                  final col = cols[index % cols.length];
                  final seat = '$row$col';

                  Color seatColor = seatColors['available']!;
                  if (reservedSeats.contains(seat)) {
                    seatColor = seatColors['reserved']!;
                  } else if (selectedSeats.contains(seat)) {
                    seatColor = seatColors['selected']!;
                  }

                  return GestureDetector(
                    onTap: reservedSeats.contains(seat)
                        ? null
                        : () => toggleSeatSelection(seat),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: seatColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: Text(
                        seat,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),

            // TYPE OF SEATS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    color: seatColors['available'],
                  ),
                ),
                const Text(
                    'Available',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: seatColors['reserved'],
                  ),
                ),
                const Text(
                    'Reserved',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    color: seatColors['selected'],
                  ),
                ),
                const Text(
                    'Selected',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            const Text(
              'Select Date & Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),

            const SizedBox(height: 20,),

            const ListDate(),

            const SizedBox(height: 20,),

            const ListTime(),

            const SizedBox(height: 20,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: MainButton(
          onPressed: () {
            if (selectedSeats.isEmpty) {
              showFalseSnackBar(
                  context,
                  'No seat selected'
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected Seats: ${selectedSeats.join(', ')}')),
              );
            }
          },
          title: 'Buy ticket',
        ),
      ),
    );
  }
}
