import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final List<int?> seatIds;
  final int? showtimeId;

  const PaymentPage({
    Key? key,
    required this.seatIds,
    required this.showtimeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Seats:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(seatIds.join(', ')),

            const SizedBox(height: 20),

            const Text(
              'Showtime ID:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text('$showtimeId'),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                },
                child: const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
