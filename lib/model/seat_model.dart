class Seat {
  final int id;
  bool isSelected;
  final bool isReserved;
  final int price; // Giá vé của ghế

  Seat({required this.id, this.isSelected = false, this.isReserved = false, required this.price,});


}

class Date {
  final String date;
  bool isSelected;

  Date({required this.date, this.isSelected = false});
}

class Time {
  final String time;
  bool isSelected;

  Time({required this.time, this.isSelected = false});
}
