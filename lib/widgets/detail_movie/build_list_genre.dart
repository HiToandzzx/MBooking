import 'package:flutter/material.dart';

class ListGenre extends StatelessWidget {
  final String genre;

  const ListGenre({Key? key, required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genreList = genre.split(',');

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genreList.length,
        itemBuilder: (context, index) {
          final genre = genreList[index].trim();
          if (genre.isEmpty) return const SizedBox();

          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1C1C1C),
            ),
            child: Text(
              genre,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}