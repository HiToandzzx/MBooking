import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/cinemaModel.dart';
import '../tab_home/viewmodel_home.dart';

class MoviePage extends StatefulWidget {
  final int initialTabIndex;

  MoviePage({required this.initialTabIndex});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  final CinemaViewModel cinemaViewModel = CinemaViewModel();
  late TabController _tabController;
  late Future<Autogenerated> futureNowPlayingMovies;
  late Future<Autogenerated> futureComingSoonMovies;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialTabIndex);
    futureNowPlayingMovies = cinemaViewModel.fetchNowPlayingMovies();
    futureComingSoonMovies = cinemaViewModel.fetchComingSoonMovies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        bottom: TabBar(
          controller: _tabController,

          labelColor: Color.fromARGB(
              255, 225, 210, 210), // Màu chữ khi được chọn là đen
          unselectedLabelColor:
          Colors.grey, // Màu chữ khi không được chọn là xám
          indicatorColor: Color.fromARGB(255, 190, 207, 4),
          // Màu của chỉ thị là đen
          tabs: [
            Tab(text: 'Now Playing'),
            Tab(text: 'Coming Soon'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMovieGrid(futureNowPlayingMovies),
          _buildMovieGrid(futureComingSoonMovies),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildMovieGrid(Future<Autogenerated> futureMovies) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<Autogenerated>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white)));
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.6,
              ),
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index) {
                Results movie = snapshot.data!.results![index];
                return _buildMovieGridItem(movie);
              },
            );
          } else {
            return Center(
                child: Text('No data available',
                    style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
///////////WIDGET BUILD MOVIE PAGE
  Widget _buildMovieGridItem(Results movie) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 191,
            height: 220, // Chiều cao đã đặt lên 400
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movie.title!,
            style: TextStyle(
                color: Color(0xFFFCC434),
                fontSize: 16,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Rating: ${movie.voteAverage} (${movie.voteCount} reviews)',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Duration: ${movie.popularity} minutes',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Genre: ${movie.popularity}',
            style: TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
