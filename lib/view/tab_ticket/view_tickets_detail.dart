import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app_ttcn/widgets/app_images.dart';
import 'package:movies_app_ttcn/widgets/app_vector.dart';
import '../../helper/format_currency.dart';
import '../../helper/format_time.dart';
import '../../view_model/viewmodel_tickets_detail.dart';
import '../../model/model_tickets_detail.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TicketDetailPage extends StatefulWidget {
  final int bookingId;

  const TicketDetailPage({Key? key, required this.bookingId}) : super(key: key);

  @override
  TicketDetailPageState createState() => TicketDetailPageState();
}

class TicketDetailPageState extends State<TicketDetailPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Ticket", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
            return Stack(
              children: [
                Image.asset(
                  AppImages.bgTicketDetail,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 80,
                  left: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // INFO MOVIE
                      Row(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(13.36),
                                child: Image.network(
                                  detail.film!.thumbnail!,
                                  width: 125,
                                  height: 177,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 170,
                                child: Text(
                                  detail.film?.filmName ?? 'Unknown',
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.timer_outlined, color: Colors.black, size: 20),
                                  const SizedBox(width: 10),
                                  Text(
                                    formatDuration(detail.film?.duration),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.local_movies_outlined, color: Colors.black, size: 20),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      detail.film?.movieGenre ?? "N/A",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 30),

                      // SEAT, ROOM, SHOWTIME
                      Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black),
                          )
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                        AppVector.calendar
                                    )
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text(
                                      detail.showtime?.startTime ?? 'Unknown',
                                      style: const TextStyle(
                                        color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      detail.showtime?.day ?? 'Unknown',
                                      style: const TextStyle(
                                        color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 25,),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                        AppVector.seat
                                    )
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text(
                                      detail.room?.roomName ?? 'Unknown',
                                      style: const TextStyle(
                                        color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    SizedBox(
                                      width: 90,
                                      child: Text(
                                        "Seat ${detail.seat?.seatNumber ?? 'Unknown'}",
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // AMOUNT
                      Row(
                        children: [
                          const Icon(Icons.currency_exchange, color: Colors.black, size: 25),
                          const SizedBox(width: 10),
                          Text(
                            formatCurrency(detail.invoice!.totalAmount!),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // LOCATION
                      const Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.black, size: 25),
                          SizedBox(width: 10),
                          Text(
                            'Vincom Ocean Park',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Row(
                        children: [
                          Icon(Icons.find_in_page_outlined, color: Colors.black, size: 25),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 300,
                            child: Text(
                              'Show this QR code to the ticket counter to receive your ticket',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //const SizedBox(height: 115),

                      // ORDER ID

                    ],
                  ),
                ),
                Positioned(
                    top: 645,
                    left: 55,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
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
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
