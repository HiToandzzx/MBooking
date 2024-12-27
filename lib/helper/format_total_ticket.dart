import 'package:intl/intl.dart';

String formatCurrency(int number) {
  final NumberFormat formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'VNĐ',
  );
  return formatter.format(number);
}
