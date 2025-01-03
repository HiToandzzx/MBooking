import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../view_model/viewmodel_stripe.dart';

class StripeForm extends StatefulWidget {
  final String? orderId;
  final int? bookingId;
  final String? amount;

  const StripeForm({
    Key? key,
    required this.orderId,
    required this.bookingId,
    required this.amount,
  }) : super(key: key);

  @override
  State<StripeForm> createState() => _StripeFormState();
}

class _StripeFormState extends State<StripeForm> {
  late final PaymentStripeViewModel _stripeViewModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _stripeViewModel = PaymentStripeViewModel();
    _stripeViewModel.fetchPaymentStripe(
      orderId: widget.orderId!,
      amount: widget.amount!,
      bookingId: widget.bookingId!,
    );
  }

  @override
  void dispose() {
    _stripeViewModel.dispose();
    super.dispose();
  }

  Future<void> _handlePayment(String clientSecret) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Initialize PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Merchant Name',
        ),
      );

      // Display PaymentSheet
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment completed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe form'),
      ),
      body: StreamBuilder<String?>(
        stream: _stripeViewModel.clientSecretStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () => _handlePayment(snapshot.data!),
                child: const Text('Pay with Stripe'),
              ),
            );
          } else {
            return const Center(child: Text('No client secret available.'));
          }
        },
      ),
    );
  }
}
