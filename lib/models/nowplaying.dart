class NowPlaying {
  List<ResultOfPlaying> result = [];
  NowPlaying.fromJson(Map<String, dynamic> json) {
    json["results"].forEach((e) {
      result.add(ResultOfPlaying.fromJson(e));
    });
  }
}

class ResultOfPlaying {
  late String poster;
  late String originalTitle;
  late String overview;
  late String originalLanguage;
  late int id;

  late bool adult;
  late dynamic vote;

  ResultOfPlaying.fromJson(Map<String, dynamic> json) {
    poster = json["poster_path"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    vote = json["vote_average"];
    adult = json["adult"];
    originalLanguage = json["original_language"];
    id = json["id"];
  }
}
