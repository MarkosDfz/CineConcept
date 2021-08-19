// To parse this JSON data, do
//
//     final generos = generosFromJson(jsonString);

import 'dart:convert';

Generos generosFromJson(String str) => Generos.fromJson(json.decode(str));

String generosToJson(Generos data) => json.encode(data.toJson());

class Generos {
    Generos({
        this.genres,
    });

    List<Genero> genres;

    factory Generos.fromJson(Map<String, dynamic> json) => Generos(
        genres: List<Genero>.from(json["genres"].map((x) => Genero.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class Genero {
    Genero({
        this.id,
        this.name,
    });

    int id;
    String name;

    factory Genero.fromJson(Map<String, dynamic> json) => Genero(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
