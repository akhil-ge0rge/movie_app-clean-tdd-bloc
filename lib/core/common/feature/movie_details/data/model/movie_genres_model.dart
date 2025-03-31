import 'dart:convert';

import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_genres.dart'
    show MovieGenres;

class MovieGenresModel extends MovieGenres {
  const MovieGenresModel({required super.id, required super.name});

  MovieGenres copyWith({int? id, String? name}) {
    return MovieGenres(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory MovieGenresModel.fromMap(Map<String, dynamic> map) {
    return MovieGenresModel(id: map['id'] ?? 0, name: map['name'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory MovieGenresModel.fromJson(String source) =>
      MovieGenresModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
