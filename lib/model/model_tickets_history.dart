class AutogeneratedTicketsHistory {
  String? status;
  String? message;
  DataMyTicketsHistory? data;

  AutogeneratedTicketsHistory({this.status, this.message, this.data});

  AutogeneratedTicketsHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DataMyTicketsHistory.fromJson(json['data']) : null;
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

class DataMyTicketsHistory {
  List<Film>? film;

  DataMyTicketsHistory({this.film});

  DataMyTicketsHistory.fromJson(Map<String, dynamic> json) {
    if (json['film'] != null) {
      film = <Film>[];
      json['film'].forEach((v) {
        film!.add(new Film.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.film != null) {
      data['film'] = this.film!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Film {
  int? bookingId;
  String? thumbnail;
  String? filmName;
  Showtime? showtime;

  Film({this.bookingId, this.thumbnail, this.filmName, this.showtime});

  Film.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    thumbnail = json['thumbnail'];
    filmName = json['film_name'];
    showtime = json['showtime'] != null
        ? new Showtime.fromJson(json['showtime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['thumbnail'] = this.thumbnail;
    data['film_name'] = this.filmName;
    if (this.showtime != null) {
      data['showtime'] = this.showtime!.toJson();
    }
    return data;
  }
}

class Showtime {
  String? startTime;
  String? day;

  Showtime({this.startTime, this.day});

  Showtime.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['day'] = this.day;
    return data;
  }
}