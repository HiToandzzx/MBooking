// import 'package:flutter/material.dart';
// import '../../model/movie_model.dart';
// import '../../view/tab_home/viewmodel_home.dart';
// import '../cinema/widget_list.dart';

// class ListDirector extends StatelessWidget {
//   const ListDirector({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<AutoGenerated>(
//       future: MovieViewModel().fetchComingSoonMovies(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.amber,
//               )
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//               child: Text(
//                   'Error: ${snapshot.error}',
//                   style: const TextStyle(color: Colors.white)
//               )
//           );
//         } else if (snapshot.hasData) {
//           return SizedBox(
//             height: 80,
//             child: buildDirectorList(
//                 snapshot.data!.results!
//             ),
//           );
//         } else {
//           return const Center(
//               child: Text(
//                   'No data available',
//                   style: TextStyle(color: Colors.white)
//               )
//           );
//         }
//       },
//     );
//   }
// }
