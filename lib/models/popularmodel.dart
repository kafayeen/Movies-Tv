class PopularModel {
  List<Result> result = [];
  PopularModel.fromJson(Map<String, dynamic> json) {
    json["results"].forEach((e) {
      result.add(Result.fromJson(e));
    });
  }
}

class Result {
  late String poster;
  late String originalTitle;
  late String overview;
  late bool adult;
  late dynamic vote;
  late String originalLanguage;
  late int id;
  Result.fromJson(Map<String, dynamic> json) {
    poster = json["poster_path"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    vote = json["vote_average"];
    adult = json["adult"];
    originalLanguage = json["original_language"];
    id = json["id"];
  }
}
