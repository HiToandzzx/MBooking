import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/ticket_separator.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My ticket',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Movie Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://m.media-amazon.com/images/I/71niXI3lxlL._AC_SY679_.jpg', // Placeholder Image
                      width: 90,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Avengers: Infinity War',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '2 hours 29 minutes',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '🎭 Action, adventure, sci-fi',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Movie Time and Seat
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.black54,size: 40,),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('14h15\'',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('10.12.2022',
                              style: TextStyle(color: Colors.black54, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.event_seat, color: Colors.black54, size: 40),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Section 4',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('Seat H7, H8',
                              style: TextStyle(color: Colors.black54, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Price
              Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.black54,size: 30,),
                  SizedBox(width: 10),
                  Text(
                    '210.000 VND',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Cinema Address
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: Colors.black54,size: 30,),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Vincom Ocean Park CGV\n4th floor, Vincom Ocean Park, Da Ton, Gia Lam, Ha Noi',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // QR Code Section
              Row(
                children: [
                  Icon(Icons.qr_code, color: Colors.black54,size: 30,),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Show this QR code to the ticket counter to receive your ticket',
                      style: TextStyle(color: Colors.black54,fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TicketSeparator(),
              SizedBox(height: 40),
              // QR Code Placeholder
              Container(
                height: 80,
                width: double.infinity,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'QR CODE',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Order ID
              Text(
                'Order ID: 78889377726',
                style: TextStyle(color: Colors.black54,fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


