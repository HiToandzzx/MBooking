class AutogeneratedTicketsDetail {
  String? status;
  String? message;
  DataTicketsDetail? data;

  AutogeneratedTicketsDetail({this.status, this.message, this.data});

  AutogeneratedTicketsDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DataTicketsDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataTicketsDetail {
  String? orderId;
  int? bookingId;
  Film? film;
  Showtime? showtime;
  Seat? seat;
  Room? room;
  Invoice? invoice;

  DataTicketsDetail(
      {this.orderId,
        this.bookingId,
        this.film,
        this.showtime,
        this.seat,
        this.room,
        this.invoice});

  DataTicketsDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    bookingId = json['booking_id'];
    film = json['film'] != null ? new Film.fromJson(json['film']) : null;
    showtime = json['showtime'] != null
        ? new Showtime.fromJson(json['showtime'])
        : null;
    seat = json['seat'] != null ? new Seat.fromJson(json['seat']) : null;
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    invoice =
    json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['booking_id'] = this.bookingId;
    if (this.film != null) {
      data['film'] = this.film!.toJson();
    }
    if (this.showtime != null) {
      data['showtime'] = this.showtime!.toJson();
    }
    if (this.seat != null) {
      data['seat'] = this.seat!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.toJson();
    }
    return data;
  }
}

class Film {
  String? filmName;
  String? movieGenre;
  int? duration;
  String? thumbnail;

  Film({this.filmName, this.movieGenre, this.duration, this.thumbnail});

  Film.fromJson(Map<String, dynamic> json) {
    filmName = json['film_name'];
    movieGenre = json['movie_genre'];
    duration = json['duration'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['film_name'] = this.filmName;
    data['movie_genre'] = this.movieGenre;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Showtime {
  int? showtimeId;
  String? startTime;
  String? day;

  Showtime({this.showtimeId, this.startTime, this.day});

  Showtime.fromJson(Map<String, dynamic> json) {
    showtimeId = json['showtime_id'];
    startTime = json['start_time'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showtime_id'] = this.showtimeId;
    data['start_time'] = this.startTime;
    data['day'] = this.day;
    return data;
  }
}

class Seat {
  String? seatNumber;

  Seat({this.seatNumber});

  Seat.fromJson(Map<String, dynamic> json) {
    seatNumber = json['seat_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seat_number'] = this.seatNumber;
    return data;
  }
}

class Room {
  String? roomName;

  Room({this.roomName});

  Room.fromJson(Map<String, dynamic> json) {
    roomName = json['room_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_name'] = this.roomName;
    return data;
  }
}

class Invoice {
  String? totalAmount;

  Invoice({this.totalAmount});

  Invoice.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    return data;
  }
}