/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import '../model/model_seats.dart';
import '../model/model_show_time.dart';

class SelectSeatsViewModel {
  final _showTimesSubject = BehaviorSubject<List<DataShowTimes>>();
  final _errorSubject = BehaviorSubject<String>();
  final _seatsSubject = BehaviorSubject<List<DataSeats>>();

  Stream<List<DataShowTimes>> get showTimesStream => _showTimesSubject.stream;
  Stream<String> get errorStream => _errorSubject.stream;
  Stream<List<DataSeats>> get seatsStream => _seatsSubject.stream;

  String? _token;

  void setToken(String token) {
    _token = token;
  }

  Future<void> fetchShowTimes(int filmId) async {
    final url = Uri.parse('https://lolifashion.social/api/showtimes/film?film_id=$filmId');
    try {
      if (_token == null) {
        _errorSubject.add('User token is missing');
        return;
      }

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final autogenerated = AutogeneratedShowTimes.fromJson(jsonData);
        if (autogenerated.data != null) {
          _showTimesSubject.add(autogenerated.data!);
        } else {
          _showTimesSubject.add([]);
        }
      } else {
        _errorSubject.add('Failed to fetch showtimes: ${response.reasonPhrase}');
      }
    } catch (e) {
      _errorSubject.add('An error occurred: $e');
    }
  }

  void dispose() {
    _showTimesSubject.close();
    _errorSubject.close();
    _seatsSubject.close();
  }
}
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_show_time.dart';

class ShowtimeViewModel {
  final _showtimesController = BehaviorSubject<List<DataShowTimes>>();
  final _loadingController = BehaviorSubject<bool>();
  final _errorController = BehaviorSubject<String?>();

  Stream<List<DataShowTimes>> get showtimesStream => _showtimesController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<String?> get errorStream => _errorController.stream;

  Future<void> fetchShowtimes(int filmId) async {
    _loadingController.add(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _errorController.add('User is not authenticated.');
        return;
      }

      final url = Uri.parse('https://lolifashion.social/api/showtimes/film?film_id=$filmId');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final showtimeResponse = AutogeneratedShowTimes.fromJson(jsonResponse);
        _showtimesController.add(showtimeResponse.data!);
      } else {
        _errorController.add('Failed to fetch showtimes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _errorController.add('An unexpected error occurred: $e');
    } finally {
      _loadingController.add(false);
    }
  }

  void dispose() {
    _showtimesController.close();
    _loadingController.close();
    _errorController.close();
  }
}

