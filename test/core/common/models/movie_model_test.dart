import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/common/models/movie_model.dart';
import 'package:movie_app/core/utils/typedef.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tMovieModel = const MovieModel(
    id: 1,
    backdropPath: "backdropPath",
    posterPath: "posterPath",
    title: "title",
    adult: false,
  );

  final tMap = jsonDecode(fixture('movie.json')) as DataMap;
  final tJson = fixture('movie.json');

  test('should be a subclass of [Movie]', () {
    expect(tMovieModel, isA<Movie>());
  });

  group('fromMap', () {
    test('should return [MovieModel] with correct data', () {
      final res = MovieModel.fromMap(tMap);

      expect(res, equals(tMovieModel));
    });
  });

  group('toMap', () {
    test('should return [Map] with proper data', () {
      final res = tMovieModel.toMap();

      expect(res, equals(tMap));
    });
  });

  group('fromJson', () {
    test('should return [MovieModel] with correct data', () {
      final res = MovieModel.fromJson(tJson);

      expect(res, equals(tMovieModel));
    });
  });

  group('toJson', () {
    test('should return [jsonData] with proper data', () {
      final res = tMovieModel.toJson();
      final expectedJson = jsonEncode(tMap);
      expect(res, equals(expectedJson));
    });
  });

  group('copyWith', () {
    test('should return a [CourseModel] with new data', () {
      final res = tMovieModel.copyWith(adult: true);

      expect(res.adult, true);
    });
  });
}
