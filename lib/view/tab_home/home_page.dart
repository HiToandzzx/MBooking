import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/details_movie/details_movie.dart';
import 'package:movies_app_ttcn/view/tab_home/viewmodel_home.dart';
import '../../model/movie_model.dart';
import '../tab_movie/movie_page.dart';
import 'package:movies_app_ttcn/widgets/build_list_home.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Column(
          children: [
            // CUSTOM APPBAR
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hi, ${user?.displayName ?? 'No Name'}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.waving_hand,
                            color: Colors.yellow,
                            size: 18,
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 11,
                        top: 12,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      // TEXT FIELD SEARCH
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 35,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Now Playing',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MoviePage(
                                        initialTabIndex: 0,
                                      ),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'See all',
                                  style: TextStyle(
                                    color: Color(0xFFFCC434),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.amber,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // NOW PLAYING
                      FutureBuilder<AutoGenerated>(
                        future: MovieViewModel().fetchNowPlayingMovies(),
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
                              height: 630,
                              child: CarouselSlider.builder(
                                itemCount: snapshot.data!.results!.length,
                                itemBuilder: (context, index, realIndex) {
                                  Results movie = snapshot.data!.results![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailMoviePage(movieId: movie.id!),
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
                                  autoPlay: false,
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
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Coming soon',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MoviePage(
                                        initialTabIndex: 1,
                                      ),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'See all',
                                  style: TextStyle(
                                    color: Color(0xFFFCC434),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                    Icons.keyboard_arrow_right,
                                  color: Colors.amber,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      // COMING SOON
                      FutureBuilder<AutoGenerated>(
                        future: MovieViewModel().fetchComingSoonMovies(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                )
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Error: ${snapshot.error}',
                                    style: const TextStyle(color: Colors.white)
                                )
                            );
                          } else if (snapshot.hasData) {
                            return SizedBox(
                              height: 350,
                              child: buildMovieList(
                                  snapshot.data!.results!
                                  .take(10)
                                  .toList()
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text(
                                    'No data available',
                                    style: TextStyle(color: Colors.white)
                                )
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}