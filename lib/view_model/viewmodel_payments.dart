import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_payments.dart';

class PaymentsViewModel {
  final _paymentsController = BehaviorSubject<AutogeneratedPayments>();
  final _loadingController = BehaviorSubject<bool>();
  final _errorController = BehaviorSubject<String?>();
  final _dataPaymentsController = BehaviorSubject<DataPayments>();

  Stream<AutogeneratedPayments> get paymentsStream => _paymentsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<String?> get errorStream => _errorController.stream;
  Stream<DataPayments> get dataPaymentsStream => _dataPaymentsController.stream;

  Future<void> fetchPayments({
    String? seatIds,
    int? showtimeId,
    String? amount,
  }) async {
    _loadingController.add(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _errorController.add('User is not authenticated.');
        return;
      }

      final url = Uri.parse('https://lolifashion.social/api/purchase');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'seat_id': seatIds,
          'showtime_id': showtimeId,
          'amount': amount
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final payments = AutogeneratedPayments.fromJson(data);
        print("Parsed tickets: $payments");

        _paymentsController.add(payments);
        _dataPaymentsController.add(payments.data!);
      } else {
        final error = jsonDecode(response.body)['message'] ?? "Unknown error";
        print("Error: $error");
        _errorController.add(error);
      }
    } catch (e) {
      print("Exception: $e");
      _errorController.add(e.toString());
    } finally {
      _loadingController.add(false);
    }
  }

  // CANCEL PAYMENTS
  Future<void> cancelPayments({
    required int? bookingId,
  }) async {
    _loadingController.add(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _errorController.add('User is not authenticated.');
        return;
      }

      final url = Uri.parse('https://lolifashion.social/api/purchase/cancel');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'booking_id': bookingId,
        }),
      );


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Cancel success: $data");
      } else {
        final error = jsonDecode(response.body)['message'] ?? "Unknown error";
        _errorController.add(error);
      }
    } catch (e) {
      _errorController.add(e.toString());
    } finally {
      _loadingController.add(false);
    }
  }

  void dispose() {
    _paymentsController.close();
    _loadingController.close();
    _errorController.close();
    _dataPaymentsController.close();
  }
}



