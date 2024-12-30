/*
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view_model/viewmodel_tickets.dart';

class PaymentPage extends StatefulWidget {
  final List<int?> seatIds;
  final int? showtimeId;
  final int? amount;

  const PaymentPage({
    Key? key,
    required this.seatIds,
    required this.showtimeId,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final TicketsViewModel _ticketsViewModel;

  @override
  void initState() {
    super.initState();
    _ticketsViewModel = TicketsViewModel();
    _ticketsViewModel.fetchTickets(
        seatIds: widget.seatIds.join(','),
        showtimeId: widget.showtimeId,
        amount: widget.amount
    );
  }

  @override
  void dispose() {
    _ticketsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<AutogeneratedTickets>(
                stream: _ticketsViewModel.ticketsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.amber,));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    final dataTickets = snapshot.data!.data;
                    if (dataTickets == null) {
                      return const Center(child: Text("No data available"));
                    }

                    final film = dataTickets.film;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order ID: ${dataTickets.orderId ?? "N/A"}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Booking ID: ${dataTickets.bookingId ?? "N/A"}",
                            style: const TextStyle(fontSize: 16)),
                        Text("Amount: ${dataTickets.amount ?? "N/A"}",
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 16),
                        if (film != null) ...[
                          Text("Film Name: ${film.filmName ?? "N/A"}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Duration: ${film.duration ?? "N/A"} minutes",
                              style: const TextStyle(fontSize: 16)),
                          Text("Genre: ${film.movieGenre ?? "N/A"}",
                              style: const TextStyle(fontSize: 16)),
                          Text("Director: ${film.director ?? "N/A"}",
                              style: const TextStyle(fontSize: 16)),
                          Text("Release Date: ${film.release ?? "N/A"}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ],
                    );
                  } else {
                    return const Center(child: Text("No data found"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/


import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final List<int?> seatIds;
  final int? showtimeId;
  final int? amount;

  const PaymentPage({
    Key? key,
    required this.seatIds,
    required this.showtimeId,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${widget.seatIds}'),
              Text('${widget.showtimeId}'),
              Text('${widget.amount}')
            ],
          ),
        ),
      ),
    );
  }
}
