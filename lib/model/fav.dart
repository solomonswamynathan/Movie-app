class Fav {
  int? id;
  String? posterPath;
  String? title;

  Fav({this.id, this.posterPath, this.title});

  Fav.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    posterPath = json["posterPath"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["posterPath"] = posterPath;
    data["title"] = title;
    return data;
  }
}
