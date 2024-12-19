import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../model/movie_model.dart';
import '../../view/details_movie/view_details_movie.dart';
import '../../view/tab_home/viewmodel_home.dart';
import 'build_movie.dart';

class NowPlayingMoviesCarousel extends StatelessWidget {
  const NowPlayingMoviesCarousel({Key? key}) : super(key: key);

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
            height: 600,
            child: CarouselSlider.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index, realIndex) {
                Data movie = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMoviePage(
                          movie: movie,
                        ),
                      ),
                    );
                  },
                  child: buildMovieCard(movie),
                );
              },
              options: CarouselOptions(
                height: 600,
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
