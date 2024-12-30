import 'package:intl/intl.dart';

String formatCurrency(String numberStr) {
  try {
    double number = double.parse(numberStr);

    final NumberFormat formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'VNĐ',
      decimalDigits: 0,
    );
    return formatter.format(number);
  } catch (e) {
    return 'Invalid number';
  }
}

