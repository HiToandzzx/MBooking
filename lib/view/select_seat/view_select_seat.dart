import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/helper/format_total_ticket.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import '../../model/model_seats.dart';
import '../../model/model_show_time.dart';
import '../../view_model/viewmodel_seats.dart';
import '../../view_model/viewmodel_show_time.dart';
import '../../widgets/app_images.dart';
import '../../widgets/select_seat/buld_show_times.dart';
import 'package:flutter/scheduler.dart';
import '../../widgets/select_seat/type_seats.dart';
import '../payments/view_payments.dart';

class SelectSeatPage extends StatefulWidget {
  final int filmId;

  const SelectSeatPage({Key? key, required this.filmId}) : super(key: key);

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  late final ShowtimeViewModel _showtimeViewModel;
  late final SeatViewModel _seatViewModel;

  List<Seats> selectedSeats = [];
  final int seatPrice = 80000;

  @override
  void initState() {
    super.initState();
    _showtimeViewModel = ShowtimeViewModel();
    _seatViewModel = SeatViewModel();
    _showtimeViewModel.fetchShowtimes(widget.filmId);
  }

  @override
  void dispose() {
    _showtimeViewModel.dispose();
    _seatViewModel.dispose();
    super.dispose();
  }

  void _toggleSeatSelection(Seats seat) {
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
    int totalPrice = selectedSeats.length * seatPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Seats',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SHOW TIMES
            SizedBox(
              height: 200,
              child: StreamBuilder<List<DataShowTimes>>(
                stream: _showtimeViewModel.showtimesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No showtimes available.'),
                    );
                  } else {
                    final showtimes = snapshot.data!;
                    return BuildShowTimes(
                      showTimes: showtimes,
                      onShowtimeSelected: (selectedDate, selectedTime) {
                        // Use SchedulerBinding to ensure the setState happens after build
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            selectedSeats.clear();
                          });
                          _seatViewModel.fetchSeats(selectedTime, selectedDate);
                        });
                      },
                    );
                  }
                },
              ),
            ),

            Image.asset(AppImages.screen),

            // SEATS
            SizedBox(
              height: 270,
              child: StreamBuilder<List<Seats>>(
                stream: _seatViewModel.seatsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No seats available.'),
                    );
                  } else {
                    final seats = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        childAspectRatio: 1,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: seats.length,
                      itemBuilder: (context, index) {
                        final seat = seats[index];
                        bool isSelected = selectedSeats.contains(seat);
                        return GestureDetector(
                          onTap: seat.status == 'available'
                              ? () {
                                  _toggleSeatSelection(seat);
                                  print(seat.seatId);
                                }
                              : null,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.amber
                                  : (seat.status == 'available' ? Colors.grey[800] : Colors.amber[100]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              seat.seatNumber ?? '',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : (seat.status == 'available' ? Colors.white : Colors.black),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            // TYPE SEATS
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TypeSeats(label: 'Available', color: Colors.grey[800]!),
                    TypeSeats(label: 'Reserved', color: Colors.amber[100]!),
                    const TypeSeats(label: 'Selected', color: Colors.amber),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40,),

            // AMOUNT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      size: 30,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      'Total: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    Text(
                      formatCurrency(totalPrice),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.amber
                      ),
                    )
                  ],
                ),

                // COUNT DOWN
                /*Column(
                  children: [
                    CountdownTimer(
                      duration: const Duration(minutes: 10),
                      onTimerComplete: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),*/
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: MainButton(
          onPressed: () async {
            if (selectedSeats.isEmpty) {
              failedSnackBar(
                  context: context,
                  message: 'Please select at least one seat!'
              );
              return;
            }

            // GET LIST seatId
            final selectedSeatIds = selectedSeats.map((seat) => seat.seatId).toList().join(',');

            // GET showtimeId FROM SeatViewModel
            final infoData = await _seatViewModel.infoStream.first;
            final selectedShowtimeId = infoData?.showtimeId;
            final startTime = infoData?.startTime;

            if (selectedShowtimeId == null) {
              failedSnackBar(
                  context: context,
                  message: 'Showtime ID not found!'
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  seatIds: selectedSeatIds,
                  showtimeId: selectedShowtimeId,
                  amount: totalPrice.toString(),
                  startTime: startTime,
                ),
              ),
            );
          },
          title: const Text('Buy ticket'),
        ),
      ),
    );
  }
}


