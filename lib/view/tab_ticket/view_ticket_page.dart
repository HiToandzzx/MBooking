import 'package:flutter/cupertino.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('ticket page'),
      ],
    ));
  }
}
