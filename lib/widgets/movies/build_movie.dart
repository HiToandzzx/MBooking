import 'package:flutter/material.dart';
import '../../helper/format_time.dart';
import '../../model/model_movie.dart';
import '../../view/details_movie/view_details_movie.dart';

// NOW PLAYING
Widget buildMovieNowPlaying(Data movie) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 310,
        height: 440,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(movie.thumbnail!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        movie.filmName!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatDuration(movie.duration),
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      const SizedBox(width: 5),
      Text(
        '${movie.movieGenre}',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
              Icons.star,
              color: Colors.yellow,
              size: 16
          ),
          Text(
            '${movie.review}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ],
  );
}

// COMING SOON
Widget buildMovieComingSoon(List<Data> movies) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: movies.length,
    itemBuilder: (context, index) {
      Data movie = movies[index];
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMoviePage(movie: movie),
                  ),
                );
              },
              child: Container(
                width: 173,
                height: 244,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.thumbnail!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 150,
              child: Text(
                movie.filmName!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.type_specimen, color: Colors.white, size: 12),
                const SizedBox(width: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    movie.movieGenre!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.date_range, color: Colors.white, size: 12),
                const SizedBox(width: 5),
                Text(
                  movie.release!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// LOGIN PAGE
Widget buildMovieLogin(Data movie) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(movie.thumbnail!),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ],
  );
}

// SEARCH IN HOME PAGE
Widget buildMovieSearch(List<Data> movies) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 0.6,
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) {
      Data movie = movies[index];
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMoviePage(movie: movie),
                ),
              );
            },
            child: Container(
              width: 173,
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie.thumbnail!),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                movie.filmName!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                formatDuration(movie.duration!),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  movie.movieGenre!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

