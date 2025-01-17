import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_seats.dart';

class SeatViewModel {
  final _seatsController = BehaviorSubject<List<Seats>>();
  final _loadingController = BehaviorSubject<bool>();
  final _errorController = BehaviorSubject<String?>();
  final _infoController = BehaviorSubject<DataSeats?>();

  Stream<List<Seats>> get seatsStream => _seatsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<String?> get errorStream => _errorController.stream;
  Stream<DataSeats?> get infoStream => _infoController.stream;

  Future<void> fetchSeats(String startTime, String day) async {
    _loadingController.add(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _errorController.add('User is not authenticated.');
        return;
      }

      final url = Uri.parse('https://lolifashion.social/api/showtimes/seats?start_time=$startTime&day=$day');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final autogeneratedSeats = AutogeneratedSeats.fromJson(jsonResponse);

        if (autogeneratedSeats.data != null) {
          final seats = autogeneratedSeats.data!.seats ?? [];
          _seatsController.add(seats);
          _infoController.add(autogeneratedSeats.data);
        } else {
          _errorController.add(autogeneratedSeats.message ?? 'No data available.');
        }
      } else {
        _errorController.add('Failed to fetch seats. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _errorController.add('An unexpected error occurred: $e');
    } finally {
      _loadingController.add(false);
    }
  }

  void dispose() {
    _seatsController.close();
    _loadingController.close();
    _errorController.close();
    _infoController.close();
  }
}
