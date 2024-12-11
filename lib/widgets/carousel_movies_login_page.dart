import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/movie_model.dart';
import '../view/tab_home/viewmodel_home.dart';
import 'build_movie_home_tab.dart';

class LoginMoviesCarousel extends StatelessWidget {
  const LoginMoviesCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AutoGenerated>(
      future: MovieViewModel().fetchComingSoonMovies(),
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
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 330,
            child: CarouselSlider.builder(
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index, realIndex) {
                Results movie = snapshot.data!.results![index];
                return buildMovieLogin(movie);
              },
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                disableCenter: true,
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