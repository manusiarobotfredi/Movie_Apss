// To parse this JSON data, do
//
//     final genre = genreFromJson(jsonString);

import 'dart:convert';

import 'package:MyMovie/models/genre.dart';

ResponseGenre genreFromJson(String str) =>
    ResponseGenre.fromJson(json.decode(str));

String genreToJson(ResponseGenre data) => json.encode(data.toJson());

class ResponseGenre {
  ResponseGenre({
    required this.genres,
  });

  List<GenreElement> genres;

  factory ResponseGenre.fromJson(Map<String, dynamic> json) => ResponseGenre(
        genres: List<GenreElement>.from(
            json["genres"].map((x) => GenreElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}
