import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/model_movie.dart';

class MovieViewModel {
  static Future<List<Data>> fetchMovies(int status) async {
    final response = await http.get(
      Uri.parse('https://lolifashion.social/api/listfilms?type=$status'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final ListMovie listMovie = ListMovie.fromJson(jsonResponse);

      return listMovie.data!;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // SEARCH MOVIE
  static Future<List<Data>> searchMovie(String name) async {
    final response = await http.get(
      Uri.parse('https://lolifashion.social/api/films/search?name=$name'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final ListMovie listMovie = ListMovie.fromJson(jsonResponse);

      return listMovie.data ?? [];
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
