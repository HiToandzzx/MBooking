import 'package:flutter/material.dart';
import '../../helper/format_time.dart';
import '../../model/model_movie.dart';
import '../../view/details_movie/view_details_movie.dart';

// NOW PLAYING
Widget buildMovieGridNowPlaying(Future<List<Data>> futureMovies) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    child: FutureBuilder<List<Data>>(
      future: futureMovies,
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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.6,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Data movie = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMoviePage(movie: movie),
                    ),
                  );
                },
                child: buildMovieGridItemNowPlaying(movie),
              );
            },
          );
        } else {
          return const Center(
              child: Text('No data available',
                  style: TextStyle(color: Colors.white)));
        }
      },
    ),
  );
}

Widget buildMovieGridItemNowPlaying(Data movie) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 191,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              movie.thumbnail!,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        movie.filmName!,
        style: const TextStyle(
            color: Color(0xFFFCC434),
            fontSize: 16,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      Row(
        children: [
          const Icon(Icons.star, color: Colors.yellow, size: 14),
          const SizedBox(width: 4),
          Text(
            '${movie.review}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.timer, color: Colors.white, size: 14),
          const SizedBox(width: 5,),
          Text(
            formatDuration(movie.duration),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.movie_sharp, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.movieGenre!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    ],
  );
}

// COMING SOON
Widget buildMovieGridComingSoon(Future<List<Data>> futureMovies) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    child: FutureBuilder<List<Data>>(
      future: futureMovies,
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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.6,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Data movie = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMoviePage(movie: movie),
                    ),
                  );
                },
                child: buildMovieGridItemComingSoon(movie),
              );
            },
          );
        } else {
          return const Center(
              child: Text('No data available',
                  style: TextStyle(color: Colors.white)));
        }
      },
    ),
  );
}

Widget buildMovieGridItemComingSoon(Data movie) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 191,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              movie.thumbnail!,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        movie.filmName!,
        style: const TextStyle(
            color: Color(0xFFFCC434),
            fontSize: 16,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          const Icon(Icons.date_range, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          Text(
            movie.release!,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.movie_sharp, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.movieGenre!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    ],
  );
}
