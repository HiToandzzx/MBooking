import 'package:flutter/material.dart';
import '../../model/seat_model.dart';
import '../../model/seat_repositity.dart';
import '../../widgets/build_select_seat.dart';

class SelectSeatPage extends StatefulWidget {
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  late Future<List<Seat>> seatsFuture;
  late Future<List<Date>> datesFuture;
  late Future<List<Time>> timesFuture;

  @override
  void initState() {
    super.initState();
    seatsFuture = fetchSeats();
    datesFuture = fetchDates();
    timesFuture = fetchTimes();
  }

  int calculateTotalPrice(List<Seat> seats) {
    return seats
        .where((seat) => seat.isSelected) // Lọc các ghế được chọn
        .fold(0, (total, seat) => total + seat.price); // Cộng dồn giá vé
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Select seat',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Seat Map
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Seat Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SeatLegend(color: Colors.grey[800]!, label: 'Available'),
                      SizedBox(width: 16),
                      SeatLegend(color: Colors.grey[600]!, label: 'Reserved'),
                      SizedBox(width: 16),
                      SeatLegend(color: Colors.yellow, label: 'Selected'),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Seats Grid
                  Expanded(
                    child: FutureBuilder<List<Seat>>(
                      future: seatsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final seats = snapshot.data!;
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: seats.length,
                            itemBuilder: (context, index) {
                              final seat = seats[index];
                              return SeatWidget(
                                seat: seat,
                                onTap: () {
                                  setState(() {
                                    seat.isSelected = !seat.isSelected;
                                  });
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Date & Time Selector
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'Select Date & Time',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 8),
                // Date Selector
                FutureBuilder<List<Date>>(
                  future: datesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final dates = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: dates.map((date) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (var d in dates) {
                                    d.isSelected = false;
                                  }
                                  date.isSelected = true;
                                });
                              },
                              child: DateCircle(
                                date: date.date,
                                isSelected: date.isSelected,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                // Time Selector
                FutureBuilder<List<Time>>(
                  future: timesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final times = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: times.map((time) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (var t in times) {
                                    t.isSelected = false;
                                  }
                                  time.isSelected = true;
                                });
                              },
                              child: TimeChip(
                                time: time.time,
                                isSelected: time.isSelected,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          // Footer
          FutureBuilder<List<Seat>>(
            future: seatsFuture,
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
                final seats = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                  ),
                  ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                      'Total\n${calculateTotalPrice(seats)} VND',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: () {
                        // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        ),
                        ),
                        child: Text(
                          'Buy ticket',
                          style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}


