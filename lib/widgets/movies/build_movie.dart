import 'package:flutter/material.dart';
import '../../helper/format_date.dart';
import '../../model/movie_model.dart';
import '../../view/details_movie/view_details_movie.dart';

// NOW PLAYING
Widget buildMovieCard(Results movie) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 310,
        height: 440,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),

      const SizedBox(height: 10),

      Text(
        movie.title!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      ),

      const SizedBox(height: 5),

      Text(
        'Popularity: ${movie.popularity}',
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),

      const SizedBox(height: 10),

      Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.yellow, size: 16),
          const SizedBox(width: 4),
          Text(
            '${movie.voteAverage}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(width: 5,),
          Text(
            '(${movie.voteCount})',
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    ],
  );
}

// COMING SOON
Widget buildMovieList(List<Results> movies) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: movies.length,
    itemBuilder: (context, index) {
      Results movie = movies[index];
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
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
                height: 244,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Column(
              children: [
                Text(
                  movie.title!,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  formatDate(movie.releaseDate),
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${movie.voteAverage}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      '(${movie.voteCount})',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
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
Widget buildMovieLogin(Results movie) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 300,
        height: 330,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ],
  );
}

// SEARCH IN HOME PAGE
Widget buildMovieSearch(List<Results> movies) {
  int currentYear = DateTime.now().year;

  List<Results> filteredMovies = movies.where((movie) {
    try {
      DateTime releaseDate = DateTime.parse(movie.releaseDate!);
      return releaseDate.year == currentYear;
    } catch (e) {
      return false;
    }
  }).toList();

  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 0.6,
    ),
    itemCount: filteredMovies.length,
    itemBuilder: (context, index) {
      Results movie = filteredMovies[index];
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
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                movie.title!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                formatDate(movie.releaseDate),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${movie.voteAverage}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${movie.voteCount})',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}



