import 'package:intl/intl.dart';

String formatDate(String? releaseDate) {
  if (releaseDate == null || releaseDate.isEmpty) {
    return 'Unknown';
  }
  try {
    DateTime parsedDate = DateTime.parse(releaseDate);
    return DateFormat('dd.MM.yyyy').format(parsedDate);
  } catch (e) {
    return 'Invalid Date';
  }
}