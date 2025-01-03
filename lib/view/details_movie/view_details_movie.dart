/*
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/helper/storyline_text.dart';
import 'package:movies_app_ttcn/view/select_seat/view_select_seat.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/detail_movie/build_list_actor_director.dart';
import 'package:movies_app_ttcn/widgets/detail_movie/build_list_director.dart';
import '../../helper/format_date.dart';
import '../../model/model_movie.dart';
import '../../widgets/detail_movie/build_cinema.dart';

class DetailMoviePage extends StatefulWidget {
  final Data movie;

  const DetailMoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  DetailMoviePageState createState() => DetailMoviePageState();
}

class DetailMoviePageState extends State<DetailMoviePage> {
  late Future<void> _loadMovieDetails;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails = _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadMovieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '${widget.movie.actor}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.amber[400],
                foregroundColor: Colors.black,
                shadowColor: Colors.black26,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.network(
                          widget.movie.thumbnail!,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                        Positioned(
                          top: 150,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1C),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_rounded,
                                        color: Colors.grey, size: 15),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Release Date: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formatDate(widget.movie.release),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.people,
                                        color: Colors.grey, size: 15),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Popularity: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${widget.movie.filmName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.yellow, size: 15),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Review: ${widget.movie.filmName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '(${widget.movie.filmName})',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: List.generate(
                                          5,
                                          (index) => const Icon(
                                            Icons.star,
                                            color: Colors.white24,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: BasicButton(
                                        onPressed: () {},
                                        title: 'Watch trailer',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 120),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Movie genre:',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Censorship:',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Language:',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the start
                                  children: [
                                    Text(
                                      '${widget.movie.thumbnail}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '${widget.movie.filmName}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '${widget.movie.filmName}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Storyline',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              OverviewText(text: '${widget.movie.filmName}'),

                              const SizedBox(height: 30),

                              const Text(
                                'Director',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // const ListDirector(),

                              const SizedBox(height: 30),

                              const Text(
                                'Actor',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // const ListActor(),

                              const SizedBox(height: 30),

                              const Text(
                                'Cinema',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              const Column(
                                children: [
                                  CinemaItem(
                                    cinemaName: 'Vincom Ocean Park CGV',
                                    cinemaDetails:
                                        '4.55 km | Da Ton, Gia Lam, Ha Noi',
                                    icon: Icons.local_movies,
                                    backgroundColor: Color(0xFF1C1C1C),
                                  ),
                                  CinemaItem(
                                    cinemaName: 'Aeon Mall CGV',
                                    cinemaDetails:
                                        '9.32 km  |  27 Co Linh, Long Bien, Ha Noi',
                                    icon: Icons.local_movies,
                                    backgroundColor: Color(0xFF1C1C1C),
                                  ),
                                  CinemaItem(
                                    cinemaName: 'Lotte Cinema Long Bien',
                                    cinemaDetails:
                                        '14.3 km  |  7-9 Nguyen Van Linh, Long Bien, Ha Noi',
                                    icon: Icons.local_movies,
                                    backgroundColor: Color(0xFF1C1C1C),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: MainButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SelectSeatPage(),
                    //     )
                    // );
                  },
                  title: const Text('Continue'),
                ),
              ),
            );
          }
        });
  }
}
*/

import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/widgets/detail_movie/storyline_text.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import 'package:movies_app_ttcn/widgets/detail_movie/build_list_genre.dart';
import '../../helper/format_time.dart';
import '../../model/model_movie.dart';
import '../../widgets/detail_movie/build_list_actor_director.dart';
import '../select_seat/view_select_seat.dart';
import '../payment_stripe/payment_form.dart';
import '../trailer/watch_trailer.dart';

class DetailMoviePage extends StatefulWidget {
  final Data movie;

  const DetailMoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  DetailMoviePageState createState() => DetailMoviePageState();
}

class DetailMoviePageState extends State<DetailMoviePage> {
  late Future<void> _loadMovieDetails;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails = _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadMovieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.network(
                          '${widget.movie.thumbnail}',
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.error)),
                        ),
                        Positioned(
                          top: 35,
                          left: 16,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.black.withOpacity(0.6),
                            foregroundColor: Colors.amber,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1C),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${widget.movie.filmName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.calendar_month_rounded,
                                        color: Colors.grey,
                                        size: 15
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Release Date: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${widget.movie.release}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.timer,
                                        color: Colors.grey,
                                        size: 15),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Duration: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formatDuration(widget.movie.duration),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.yellow, size: 15),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Review: ${widget.movie.review}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 110),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          BasicButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrailerPage(
                                    trailerUrl: '${widget.movie.trailerLink}',
                                  ),
                                ),
                              );
                            },
                            title: 'Watch trailer',
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Movie genre:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Censorship:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Language:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListGenre(genre: widget.movie.movieGenre!),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${widget.movie.censorship}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${widget.movie.language}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Storyline',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // STORY LINE
                              StoryLineText(text: '${widget.movie.storyLine}'),
                              const SizedBox(height: 30),
                              const Text(
                                'Director',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // LIST DIRECTOR
                              ListActorDirector(actors: widget.movie.director!,),
                              const SizedBox(height: 30),
                              const Text(
                                'Actor',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // LIST ACTOR
                              ListActorDirector(actors: widget.movie.actor!,),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: MainButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectSeatPage(filmId: widget.movie.id!),
                        )
                    );
                  },
                  title: const Text('Continue'),
                ),
              ),
            );
          }
        });
  }
}
