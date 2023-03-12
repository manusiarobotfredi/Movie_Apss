class GenreElement {
  GenreElement({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory GenreElement.fromJson(Map<String, dynamic> json) => GenreElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
