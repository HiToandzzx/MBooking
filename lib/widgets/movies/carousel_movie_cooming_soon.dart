import 'package:flutter/material.dart';
import '../../model/movie_model.dart';
import '../../view/tab_home/viewmodel_home.dart';
import 'build_movie.dart';

class ComingSoonMovieCarousel extends StatelessWidget {
  const ComingSoonMovieCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: MovieViewModel.fetchMovies(1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.amber,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 350,
            child: buildMovieList(snapshot.data!),
          );
        } else {
          return const Center(
              child: Text('No data available',
                  style: TextStyle(color: Colors.white)));
        }
      },
    );
  }
}
