import 'package:intl/intl.dart';

String formatDate(String? releaseDate) {
  if (releaseDate == null || releaseDate.isEmpty) {
    return 'Unknown'; // Trả về giá trị mặc định nếu không có ngày
  }
  try {
    // Parse chuỗi ngày gốc
    DateTime parsedDate = DateTime.parse(releaseDate);
    return DateFormat('dd.MM.yyyy').format(parsedDate);
  } catch (e) {
    return 'Invalid Date'; // Trả về lỗi nếu định dạng sai
  }
}