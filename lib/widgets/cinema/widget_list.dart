// import 'package:flutter/material.dart';
// import 'package:movies_app_ttcn/model/movie_model.dart';

// // DIRECTOR
// Widget buildDirectorList(List<Results> movies) {
//   return ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: movies.length,
//     itemBuilder: (context, index) {
//       Results movie = movies[index];
//       return Padding(
//         padding: const EdgeInsets.only(right: 16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF1C1C1C),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           'https://image.tmdb.org/t/p/w200${movie.posterPath}'
//                       ),
//                       fit: BoxFit.fill,
//                     ),
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 Text(
//                   movie.title!,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// // ACTOR
// Widget buildActorList(List<Results> movies) {
//   return ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: movies.length,
//     itemBuilder: (context, index) {
//       Results movie = movies[index];
//       return Padding(
//         padding: const EdgeInsets.only(right: 16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF1C1C1C),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           'https://image.tmdb.org/t/p/w200${movie.posterPath}'
//                       ),
//                       fit: BoxFit.fill,
//                     ),
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 Text(
//                   movie.title!,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }