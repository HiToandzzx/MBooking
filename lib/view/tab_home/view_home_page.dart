import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/widgets/movies/carousel_movie_cooming_soon.dart';
import '../../widgets/movies/carousel_movie_now_playing.dart';
import '../../widgets/movies/carousel_search_movie.dart';
import '../tab_movie/view_movie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Welcome back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.waving_hand,
                            color: Colors.yellow,
                            size: 20,
                          )
                        ],
                      )
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

            // SEARCH TEXT FIELD
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
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

            const SizedBox(height: 30),

            // MAIN CONTENT
            Expanded(
              child:
               _searchQuery.isNotEmpty
                  ? SearchMovieCarousel(query: _searchQuery)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             const Text(
                               'Now Playing',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 24,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             TextButton(
                               onPressed: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => const MoviePage(
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

                         const SizedBox(height: 20),

                         // NOW PLAYING
                         const NowPlayingMoviesCarousel(),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             const Text(
                               'Coming soon',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 24,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             TextButton(
                               onPressed: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => const MoviePage(
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
                         const ComingSoonMovieCarousel(),
                       ],
                     ),
               ),
            ),
          ],
        ),
      ),
    );
  }
}

