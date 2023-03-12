import 'dart:convert';

import 'package:MyMovie/models/movie.dart';

ResponseMovie ResponseMovieFromJson(String str) =>
    ResponseMovie.fromJson(json.decode(str));

String ResponseMovieToJson(ResponseMovie data) => json.encode(data.toJson());

class ResponseMovie {
  ResponseMovie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory ResponseMovie.fromJson(Map<String, dynamic> json) => ResponseMovie(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

enum OriginalLanguage { EN, IT, ES }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "it": OriginalLanguage.IT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
