import 'package:flutter/material.dart';

class DetailMoviePage extends StatelessWidget {
  final int movieId;

  const DetailMoviePage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: Center(
        child: Text(
          'Movie ID: $movieId',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
