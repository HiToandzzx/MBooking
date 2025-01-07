import 'package:flutter/material.dart';
import '../../model/model_tickets_history.dart';
import '../../view_model/viewmodel_tickets_history.dart';
import 'view_tickets_detail.dart';

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  TicketHistoryPageState createState() => TicketHistoryPageState();
}

class TicketHistoryPageState extends State<TicketHistoryPage> {
  late final TicketsHistoryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TicketsHistoryViewModel();
    _viewModel.fetchTicketsHistory();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _reloadTickets() async {
    await _viewModel.fetchTicketsHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: _reloadTickets,
          color: Colors.amber,
          child: StreamBuilder<DataMyTicketsHistory>(
            stream: _viewModel.ticketsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.amber));
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No data available"));
              } else {
                final dataTickets = snapshot.data!;
                final films = dataTickets.film;
                if (films == null || films.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.tv_off, size: 100, color: Colors.amber),
                        SizedBox(height: 10),
                        Text(
                          "Tickets is empty",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: films.length,
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return GestureDetector(
                      onTap: () {
                        if (film.bookingId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TicketDetailPage(bookingId: film.bookingId!),
                            ),
                          );
                        }
                      },
                      child: Card(
                        color: const Color(0xFF1C1C1C),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
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
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
                                        const SizedBox(width: 10),
                                        Text(
                                          film.showtime?.startTime?.substring(0, 5) ?? "N/A",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.date_range_outlined, color: Colors.white, size: 20),
                                        const SizedBox(width: 10),
                                        Text(
                                          film.showtime?.day ?? "N/A",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
