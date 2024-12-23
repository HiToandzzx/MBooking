import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../model/model_movie.dart';
import '../../view_model/viewmodel_movie.dart';
import 'build_movie.dart';

class LoginMoviesCarousel extends StatelessWidget {
  const LoginMoviesCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: MovieViewModel.fetchMovies(0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error: \${snapshot.error}',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 300,
            child: CarouselSlider.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index, realIndex) {
                Data movie = snapshot.data![index];
                return buildMovieLogin(movie);
              },
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                disableCenter: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                scrollPhysics: const BouncingScrollPhysics(),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}
