import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/bot_nav/bot_nav.dart';
import 'package:movies_app_ttcn/widgets/app_images.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import '../../helper/format_currency.dart';
import '../../helper/format_time.dart';
import '../../view_model/viewmodel_tickets_detail.dart';
import '../../model/model_tickets_detail.dart';
import 'package:barcode_widget/barcode_widget.dart';

import '../../widgets/showtime_seat_ticket.dart';

class TicketDetailByTripePage extends StatefulWidget {
  final int bookingId;

  const TicketDetailByTripePage({Key? key, required this.bookingId}) : super(key: key);

  @override
  TicketDetailByTripePageState createState() => TicketDetailByTripePageState();
}

class TicketDetailByTripePageState extends State<TicketDetailByTripePage> {
  late final TicketsDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TicketsDetailViewModel();
    _viewModel.fetchTicketsDetail(widget.bookingId);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Ticket", style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const BotNav(),)
                    );
                  },
                  icon: const Icon(
                      Icons.home_filled,
                    size: 30,
                  )
              ),
            )
          ],
        ),
        body: StreamBuilder<DataTicketsDetail>(
          stream: _viewModel.ticketsDetailStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.amber));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No ticket detail available"));
            } else {
              final detail = snapshot.data!;
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.bgTicketDetail),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // INFO MOVIE
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(13.36),
                                child: Image.network(
                                  detail.film!.thumbnail!,
                                  width: 125,
                                  height: 177,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.film?.filmName ?? 'Unknown',
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.timer_outlined,
                                            color: Colors.black,
                                            size: 20
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          formatDuration(detail.film?.duration),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.local_movies_outlined,
                                            color: Colors.black,
                                            size: 20
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            detail.film?.movieGenre ?? 'N/A',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // SEAT, ROOM, SHOWTIME
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildDetailColumn(
                                icon: AppVector.calendar,
                                title: detail.showtime?.startTime?.substring(0, 5) ?? 'Unknown',
                                subtitle: detail.showtime?.day ?? 'Unknown',
                              ),
                              buildDetailColumn(
                                icon: AppVector.seat,
                                title: detail.room?.roomName ?? 'Unknown',
                                subtitle: "Seat ${detail.seat?.seatNumber ??
                                    'Unknown'}",
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // AMOUNT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                  Icons.currency_exchange,
                                  color: Colors.black,
                                  size: 25
                              ),
                              const SizedBox(width: 10),
                              Text(
                                formatCurrency(detail.invoice!.totalAmount!),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // LOCATION
                          const Row(
                            children: [
                              Icon(
                                  Icons.location_on_outlined, color: Colors.black,
                                  size: 25),
                              SizedBox(width: 10),
                              Text(
                                'Vincom Ocean Park',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1, color: Colors.black),
                                )
                            ),
                            padding: const EdgeInsets.only(bottom: 30),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                    Icons.find_in_page_outlined, color: Colors.black,
                                    size: 25),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Show this QR code to the ticket counter to receive your ticket',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          BarcodeWidget(
                            data: detail.orderId!,
                            barcode: Barcode.code128(),
                            width: 280,
                            height: 70,
                            drawText: false,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Order ID: ${detail.orderId ?? 'Unknown'}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
