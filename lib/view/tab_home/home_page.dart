import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_ttcn/view/tab_home/viewmodel_home.dart';
import '../../model/cinemaModel.dart';
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
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                const Text(
                                  'Now Playing',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 125),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MoviePage(
                                            initialTabIndex: 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(
                                        color: Color(0xFFFCC434),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 10),
                            FutureBuilder<Autogenerated>(
                              future: CinemaViewModel().fetchNowPlayingMovies(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}',
                                          style: TextStyle(color: Colors.white)));
                                } else if (snapshot.hasData) {
                                  return Container(
                                    height: 600, // Đặt chiều cao cho PageView
                                    child: PageView.builder(
                                      controller: PageController(viewportFraction: 0.8),
                                      itemCount: snapshot.data!.results!.length,
                                      itemBuilder: (context, index) {
                                        Results movie = snapshot.data!.results![index];
                                        return _buildMovieCard(movie);
                                      },
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: Text('No data available',
                                          style: TextStyle(color: Colors.white)));
                                }
                              },
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Coming soon',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 115),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MoviePage(
                                            initialTabIndex: 1,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(
                                        color: Color(0xFFFCC434),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 10),
                            FutureBuilder<Autogenerated>(
                              future: CinemaViewModel().fetchComingSoonMovies(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}',
                                          style: TextStyle(color: Colors.white)));
                                } else if (snapshot.hasData) {
                                  return Container(
                                    height: 250, // Đặt chiều cao cho ListView.builder
                                    child: _buildMovieList(snapshot.data!.results!
                                        .take(10)
                                        .toList()), // Hiển thị 10 phim tiếp theo
                                  );
                                } else {
                                  return Center(
                                      child: Text('No data available',
                                          style: TextStyle(color: Colors.white)));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


////////////////////////widget tao 2 list movie
  Widget _buildMovieCard(Results movie) {
    return Container(
      padding: EdgeInsets.all(
          10), // Thêm padding để đảm bảo khoảng cách giữa các thành phần
      decoration: BoxDecoration(
        color: Colors.black, // Màu nền của thẻ phim
        borderRadius: BorderRadius.circular(16), // Bo tròn các góc của thẻ phim
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 310, // Điều chỉnh chiều rộng cho ảnh phim
            height: 440, // Điều chỉnh chiều cao cho ảnh phim
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(16.0), // Bo tròn các góc của ảnh phim
              image: DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.title!,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Căn giữa tiêu đề
          ),
          const SizedBox(height: 5), // Giảm khoảng cách giữa các thành phần
          Text(
            'Release date: ${movie.releaseDate}',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10), // Giảm khoảng cách giữa các thành phần
          Center(
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center, // Căn giữa nội dung trong hàng
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${movie.voteAverage}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(List<Results> movies) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        Results movie = movies[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.title!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Release date: ${movie.releaseDate}',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${movie.voteAverage}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

