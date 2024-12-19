import 'package:flutter/material.dart';


import 'package:movies_app_ttcn/view/payment/view_payment_page.dart';

import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/model/seat_model.dart';
import 'package:movies_app_ttcn/model/seat_repositity.dart';

import '../../widgets/app_images.dart';
import '../../widgets/select_seat/build_list_time.dart';
import '../../widgets/select_seat/buld_list_date.dart';

class SelectSeatPage extends StatefulWidget {
  const SelectSeatPage({super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  late Future<Autogenerated> seatDataFuture;
  final List<String> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    seatDataFuture = fetchSeatData();
  }

  final Map<String, Color> seatColors = {
    'available': Colors.grey.withOpacity(0.3),
    'reserved': Colors.amber.withOpacity(0.2),
    'selected': Colors.amber,
  };

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
        child: FutureBuilder<Autogenerated>(
          future: seatDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.amber,));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data available'));
            } else{
              final seats = snapshot.data!.data!.seat!;
              seats.sort((a, b) {
                // Extract letter and number parts of the seat_number
                final aMatch = RegExp(r'([A-Z]+)(\d+)').firstMatch(a.seatNumber!);
                final bMatch = RegExp(r'([A-Z]+)(\d+)').firstMatch(b.seatNumber!);

                if (aMatch != null && bMatch != null) {
                  // Compare letters first
                  final letterComparison = aMatch.group(1)!.compareTo(bMatch.group(1)!);
                  if (letterComparison != 0) {
                    return letterComparison;
                  }

                  // Compare numbers next
                  final aNumber = int.parse(aMatch.group(2)!);
                  final bNumber = int.parse(bMatch.group(2)!);
                  return aNumber.compareTo(bNumber);
                }

                // Fallback to default string comparison if parsing fails
                return a.seatNumber!.compareTo(b.seatNumber!);
              });
              final cols = snapshot.data!.data!.col ?? 8;

              return Column(
                children: [
                  const SizedBox(height: 10),
                  const Image(image: AssetImage(AppImages.screen)),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: seats.length,
                      itemBuilder: (context, index) {
                        final seat = seats[index];
                        final seatColor = seat.seatStatus == 'Reserved'
                            ? Colors.amber.withOpacity(0.2)
                            : selectedSeats.contains(seat.seatNumber)
                            ? Colors.amber
                            : Colors.grey.withOpacity(0.3);

                        return GestureDetector(
                          onTap: seat.seatStatus == 'Reserved'
                              ? null
                              : () => toggleSeatSelection(seat.seatNumber!),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: seatColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black, width: 0.5),
                            ),
                            child: Text(
                              seat.seatNumber!,
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

                  const SizedBox(height: 20),
                  const ListDate(),
                  const SizedBox(height: 20),
                  const ListTime(),
                  const SizedBox(height: 20),
                ],
              );
            } 
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: ${(selectedSeats.length * 80000).toStringAsFixed(0)} VND',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            MainButton(
              onPressed: () {
                if (selectedSeats.isEmpty) {
                 SnackBar(content: Text('No selected seats'));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected Seats: ${selectedSeats.join(', ')}')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentPage()),
                  );
                }
              },
              title: Text('Buy ticket'),
            ),
          ],
        ),
      ),
    );
  }
}
