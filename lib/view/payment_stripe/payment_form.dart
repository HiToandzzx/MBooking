import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentForm extends StatelessWidget {
  const PaymentForm({super.key});

  // Hàm xử lý thanh toán với Stripe
  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      // Gọi API Backend để lấy `client_secret`
      final response = await http.post(
        Uri.parse('http://192.168.3.29:3000/api/create-payment-intent'),
        body: {'amount': '2000', 'booking_id': '123'}, // Số tiền và dữ liệu booking
      );
      if (response.statusCode == 200) {
        final paymentIntent = jsonDecode(response.body);
        final clientSecret = paymentIntent['clientSecret'];

        // Cấu hình PaymentSheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Movie Tickets',
          ),
        );

        // Hiển thị PaymentSheet
        await Stripe.instance.presentPaymentSheet();

        // Thanh toán thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment Successful')),
        );

      } else {
        throw Exception('Failed to load payment intent');
      }
    } catch (e) {
      // Xử lý lỗi thanh toán
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => displayPaymentSheet(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Pay Now',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
