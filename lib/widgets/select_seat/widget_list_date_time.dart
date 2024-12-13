import 'package:flutter/material.dart';
import '../../model/movie_model.dart';

Widget buildDateList(List<Results> movies) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: movies.length,
    itemBuilder: (context, index) {
      Results movie = movies[index];
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C).withOpacity(0.7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 8),
                /*Text(
                  movie.title!,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),*/
                const Text('Dec'),
                const SizedBox(height: 10),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                      ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildTimeList(List<Results> movies) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: movies.length,
    itemBuilder: (context, index) {
      Results movie = movies[index];
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C).withOpacity(0.7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  movie.title!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}