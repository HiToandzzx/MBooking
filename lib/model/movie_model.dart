class ListMovie {
  String? status;
  String? message;
  List<Data>? data;

  ListMovie({this.status, this.message, this.data});

  ListMovie.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? filmName;
  String? thumbnail;
  String? duration;
  double? review;
  String? storyLine;
  String? movieGenre;
  String? censorship;
  String? language;
  String? director;
  String? actor;
  int? status;
  String? release;

  Data(
      {this.id,
      this.filmName,
      this.thumbnail,
      this.duration,
      this.review,
      this.storyLine,
      this.movieGenre,
      this.censorship,
      this.language,
      this.director,
      this.actor,
      this.status,
      this.release});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filmName = json['film_name'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    review = json['review'];
    storyLine = json['story_line'];
    movieGenre = json['movie_genre'];
    censorship = json['censorship'];
    language = json['language'];
    director = json['director'];
    actor = json['actor'];
    status = json['status'];
    release = json['release'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['film_name'] = this.filmName;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['review'] = this.review;
    data['story_line'] = this.storyLine;
    data['movie_genre'] = this.movieGenre;
    data['censorship'] = this.censorship;
    data['language'] = this.language;
    data['director'] = this.director;
    data['actor'] = this.actor;
    data['status'] = this.status;
    data['release'] = this.release;
    return data;
  }
}
