import 'package:flutter/material.dart';
import '../../model/model_movie.dart';
import '../../widgets/movies/build_movies_tab.dart';
import '../../view_model/viewmodel_movie.dart';

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
    _loadMovies();
  }

  void _loadMovies() {
    setState(() {
      futureNowPlayingMovies = MovieViewModel.fetchMovies(0);
      futureComingSoonMovies = MovieViewModel.fetchMovies(1);
    });
  }

  Future<void> _refreshMovies() async {
    _loadMovies();
    await Future.delayed(const Duration(milliseconds: 500));
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
          RefreshIndicator(
            onRefresh: _refreshMovies,
            color: Colors.amber,
            child: buildMovieGridNowPlaying(futureNowPlayingMovies),
          ),
          RefreshIndicator(
            onRefresh: _refreshMovies,
            color: Colors.amber,
            child: buildMovieGridComingSoon(futureComingSoonMovies),
          ),
        ],
      ),
    );
  }
}
