import'../../model/seat_model.dart';

Future<List<Seat>> fetchSeats() async {
  await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian tải
  return List.generate(
    64,
        (index) => Seat(
      id: index + 1,
      isReserved: index % 7 == 0, // Một số ghế bị đặt trước
      price: 70000, // Giá vé cố định
    ),
  );
}


Future<List<Date>> fetchDates() async {
 // Gọi API hoặc truy vấn cơ sở dữ liệu để lấy dữ liệu ngày
// Ví dụ giả định:
return List.generate(7, (index) => Date(date: 'Dec ${10 + index}'));
}

Future<List<Time>> fetchTimes() async {
  // Gọi API hoặc truy vấn cơ sở dữ liệu để lấy dữ liệu giờ
  // Ví dụ giả định:
  return [
    Time(time: '11:05'),
    Time(time: '14:15'),
    Time(time: '16:30'),
    Time(time: '20:30'),
  ];
}