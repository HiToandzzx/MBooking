import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import '../../helper/format_currency.dart';
import '../../model/model_payments.dart';
import '../../view_model/viewmodel_payments.dart';

class PaymentPage extends StatefulWidget {
  final String? seatIds;
  final int? showtimeId;
  final String? amount;
  final String? startTime;

  const PaymentPage({
    Key? key,
    required this.seatIds,
    required this.showtimeId,
    required this.amount,
    required this.startTime,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final PaymentsViewModel _paymentsViewModel;
  int? _bookingId;

  @override
  void initState() {
    super.initState();
    _paymentsViewModel = PaymentsViewModel();
    _paymentsViewModel.fetchPayments(
      seatIds: widget.seatIds,
      showtimeId: widget.showtimeId,
      amount: widget.amount,
    );
  }

  @override
  void dispose() {
    _paymentsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // CHẶN KHÔNG CHO NGƯỜI DÙNG POP VỀ
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              if (_bookingId != null) {
                await _paymentsViewModel.cancelPayments(bookingId: _bookingId!);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking ID is not available!')),
                );
              }
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<bool>(
                    stream: _paymentsViewModel.loadingStream,
                    builder: (context, loadingSnapshot) {
                      if (loadingSnapshot.data == true) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.amber),
                        );
                      }

                      return StreamBuilder<DataPayments?>(
                        stream: _paymentsViewModel.dataPaymentsStream,
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.amber),
                            );
                          } else if (dataSnapshot.hasError) {
                            return Center(
                              child: Text('Error: ${dataSnapshot.error}'),
                            );
                          } else if (dataSnapshot.hasData && dataSnapshot.data != null) {
                            final data = dataSnapshot.data!;
                            final film = data.film;
                            final seat = data.seats;

                            _bookingId = data.bookingId!; // LƯU ĐỂ GỌI APPBAR

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // INFO MOVIE
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1C1C1C),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                      children: [
                                        if (film != null) ...[
                                          Row(
                                            children: [
                                              film.thumbnail != null
                                                  ? ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                                child: Image.network(
                                                  film.thumbnail!,
                                                  height: 139,
                                                  width: 120,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : const Icon(Icons.movie, size: 100),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        film.filmName ?? "No film name",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.amber
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
                                                          const SizedBox(width: 10),
                                                          SizedBox(
                                                            width: 140,
                                                            child: Text(
                                                              film.movieGenre ?? 'N/A',
                                                              style: const TextStyle(fontSize: 16),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.date_range_outlined, color: Colors.white, size: 20),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            film.release ?? 'N/A',
                                                            style: const TextStyle(fontSize: 16),
                                                          ),
                                                          const SizedBox(width: 5),
                                                          const Text(
                                                            '- ',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            widget.startTime!.substring(0, 5),
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ]
                                  ),
                                ),

                                const SizedBox(height: 30,),

                                // ORDER ID
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Order ID",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      data.orderId!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10,),

                                // SEATS
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Seat",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (seat != null && seat.isNotEmpty)
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: Text(
                                                seat.map((s) => s.seatNumber ?? 'N/A').join(', '),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      const Text(
                                        "No Seats",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 30,),

                                // AMOUNT
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 1, color: Colors.grey),
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(data.amount!),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 30,),

                                MainButton(
                                    onPressed: () {

                                    },
                                    title: const Text('Continue')
                                )
                              ],
                            );

                          } else {
                            return const Center(
                              child: Text('No Data Available'),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



