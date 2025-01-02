import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/widgets/movies/build_movie.dart';
import '../../model/model_movie.dart';
import '../../view_model/viewmodel_movie.dart';

class SearchMovieCarousel extends StatelessWidget {
  final String query;

  const SearchMovieCarousel({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: MovieViewModel.searchMovie(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SizedBox(
            height: 350,
            child: buildMovieSearch(snapshot.data!),
          );
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    Icons.tv_off,
                    size: 50,
                    color: Colors.amber,
                ),
                SizedBox(height: 20,),
                Text(
                  'No movies found',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
