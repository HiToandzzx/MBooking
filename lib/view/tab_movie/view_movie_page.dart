import 'package:flutter/material.dart';
import '../../model/movie_model.dart';
import '../../widgets/movies/build_movies_tab.dart';
import '../tab_home/viewmodel_home.dart';

class MoviePage extends StatefulWidget {
  final int initialTabIndex;

  const MoviePage({super.key, required this.initialTabIndex});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  final MovieViewModel movieViewModel = MovieViewModel();
  late TabController _tabController;
  late Future<List<Data>> futureNowPlayingMovies;
  late Future<List<Data>> futureComingSoonMovies;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialTabIndex);
    futureNowPlayingMovies = MovieViewModel.fetchMovies(0);
    futureComingSoonMovies = MovieViewModel.fetchMovies(1);
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
        title: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          unselectedLabelColor: Colors.grey,
          indicator: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Now Playing'),
            Tab(text: 'Coming Soon'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildMovieGridNowPlaying(futureNowPlayingMovies),
          buildMovieGridComingSoon(futureComingSoonMovies),
        ],
      ),
    );
  }
}
