import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:movies_app_ttcn/helper/snack_bar.dart';
import 'package:movies_app_ttcn/view/bot_nav/bot_nav.dart';
import 'package:movies_app_ttcn/widgets/app_images.dart';
import 'package:movies_app_ttcn/widgets/basic_button.dart';
import '../../helper/format_currency.dart';
import '../../model/model_payments.dart';
import '../../view_model/viewmodel_payments.dart';
import '../../view_model/viewmodel_stripe.dart';

class PaymentPage extends StatefulWidget {
  final String? seatIds;
  final int? showtimeId;
  final String? amount;
  final String? startTime;

  const PaymentPage({
    Key? key,
    required this.seatIds,
    required this.showtimeId,
    required this.amount,
    required this.startTime,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final PaymentsViewModel _paymentsViewModel;

  late final PaymentStripeViewModel _stripeViewModel;

  int? _bookingId;
  bool _isSelected = false;
  bool _isLoadingPayment = false;

  void _selectPaymentMethod() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    _stripeViewModel = PaymentStripeViewModel();
    _paymentsViewModel = PaymentsViewModel();
    _paymentsViewModel.fetchPayments(
      seatIds: widget.seatIds,
      showtimeId: widget.showtimeId,
      amount: widget.amount,
    );
  }

  @override
  void dispose() {
    _paymentsViewModel.dispose();
    _stripeViewModel.dispose();
    super.dispose();
  }

  Future<void> _handleStripePayment(String orderId, String amount, int bookingId) async {
    setState(() {
      _isLoadingPayment = true;
    });

    try {
      await _stripeViewModel.fetchPaymentStripe(
        orderId: orderId,
        amount: amount,
        bookingId: bookingId,
      );

      final clientSecret = await _stripeViewModel.clientSecretStream.first;

      if (clientSecret == null) {
        print('Failed to get client secret.');
        return;
      }

      // Initialize PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Merchant Name',
        ),
      );

      // Display PaymentSheet
      await Stripe.instance.presentPaymentSheet();

      successSnackBar(
          context: context,
          message: 'Payment successful!'
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BotNav(),
          )
      );

    } catch (e) {
      return;
    } finally {
      setState(() {
        _isLoadingPayment = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // CHẶN KHÔNG CHO NGƯỜI DÙNG BACK VỀ
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              if (_bookingId != null) {
                await _paymentsViewModel.cancelPayments(bookingId: _bookingId!);
                Navigator.pop(context);
              } else {
                return;
              }
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<bool>(
                    stream: _paymentsViewModel.loadingStream,
                    builder: (context, loadingSnapshot) {
                      if (loadingSnapshot.data == true) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.amber),
                        );
                      }

                      return StreamBuilder<DataPayments?>(
                        stream: _paymentsViewModel.dataPaymentsStream,
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.amber),
                            );
                          } else if (dataSnapshot.hasError) {
                            return Center(
                              child: Text('Error: ${dataSnapshot.error}'),
                            );
                          } else if (dataSnapshot.hasData && dataSnapshot.data != null) {
                            final data = dataSnapshot.data!;
                            final film = data.film;
                            final seat = data.seats;

                            _bookingId = data.bookingId!; // LƯU ĐỂ GỌI APPBAR

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // INFO MOVIE
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1C1C1C),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                      children: [
                                        if (film != null) ...[
                                          Row(
                                            children: [
                                              film.thumbnail != null
                                                  ? ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                                child: Image.network(
                                                  film.thumbnail!,
                                                  height: 139,
                                                  width: 120,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : const Icon(Icons.movie, size: 100),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        film.filmName ?? "No film name",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.amber
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
                                                          const SizedBox(width: 10),
                                                          SizedBox(
                                                            width: 140,
                                                            child: Text(
                                                              film.movieGenre ?? 'N/A',
                                                              style: const TextStyle(fontSize: 16),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.date_range_outlined, color: Colors.white, size: 20),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            film.release ?? 'N/A',
                                                            style: const TextStyle(fontSize: 16),
                                                          ),
                                                          const SizedBox(width: 5),
                                                          const Text(
                                                            '- ',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            widget.startTime!.substring(0, 5),
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ]
                                  ),
                                ),

                                const SizedBox(height: 30,),

                                // ORDER ID
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Order ID",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      data.orderId!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10,),

                                // SEATS
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Seat",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (seat != null && seat.isNotEmpty)
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: Text(
                                                seat.map((s) => s.seatNumber ?? 'N/A').join(', '),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      const Text(
                                        "No Seats",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 30,),

                                // AMOUNT
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 1, color: Colors.grey),
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(data.amount!),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 40,),

                                const Row(
                                  children: [
                                    Text(
                                      'Payment Method',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20,),


                                GestureDetector(
                                  onTap: _selectPaymentMethod,
                                  child: Container(
                                    width: double.infinity,
                                    height: 80,
                                    padding: const EdgeInsets.only(left: 15, right: 5),
                                    decoration: BoxDecoration(
                                      //color: const Color(0xFF1C1C1C),
                                      color: _isSelected ? Colors.amber.withOpacity(0.2) : const Color(0xFF1C1C1C),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _isSelected ? Colors.amber : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.logoStripe,
                                          width: 86,
                                          height: 48,
                                        ),
                                        const SizedBox(width: 15),
                                        const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'International payments',
                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '(Visa, Master, JCB, Amex)',
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.navigate_next, size: 40),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 40,),

                                /*MainButton(
                                    onPressed: () {
                                      if (!_isSelected) {
                                        failedSnackBar(
                                            context: context,
                                            message: 'Please select payment method'
                                        );
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => StripeForm(
                                                    orderId: data.orderId!,
                                                    bookingId: _bookingId!,
                                                    amount: data.amount!
                                                ),
                                            )
                                        );
                                      }
                                    },
                                    title: const Text('Continue')
                                )*/
                                _isLoadingPayment
                                    ? const CircularProgressIndicator(color: Colors.amber)
                                    : MainButton(
                                      onPressed: () {
                                        if (!_isSelected) {
                                          failedSnackBar(
                                            context: context,
                                            message: 'Please select a payment method',
                                          );
                                        } else {
                                          _handleStripePayment(
                                            data.orderId!,
                                            data.amount!,
                                            _bookingId!,
                                          );
                                        }
                                      },
                                      title: const Text('Continue'),
                                    ),
                              ],
                            );

                          } else {
                            return const Center(
                              child: Text('No Data Available'),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



