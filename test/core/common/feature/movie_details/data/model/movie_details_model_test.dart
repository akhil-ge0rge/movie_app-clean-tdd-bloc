import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/common/feature/movie_details/data/model/movie_detail_model.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/utils/typedef.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  final tMovieDetailsModel = const MovieDetailModel(
    id: 1,
    originalTitle: "",
    adult: false,
    backdropPath: "",
    genres: [],
    overview: "",
    posterPath: "",
    releaseDate: "",
  );

  final tMap = jsonDecode(fixture('movie_details.json')) as DataMap;
  final tJson = fixture('movie_details.json');

  test('should be a subsclass of [MovieDetils]', () {
    expect(tMovieDetailsModel, isA<MovieDetail>());
  });

  group('fromMap', () {
    test('should return [MovieDetailsModel] with correct data', () {
      final res = MovieDetailModel.fromMap(tMap);

      expect(res, equals(tMovieDetailsModel));
    });
  });

  group('toMap', () {
    test('should return [Map] with proper data', () {
      final res = tMovieDetailsModel.toMap();
      expect(res, equals(tMap));
    });
  });

  group('fromJson', () {
    test('should return [MovieDetailsModel] with correct data', () {
      final res = MovieDetailModel.fromJson(tJson);
      expect(res, equals(tMovieDetailsModel));
    });
  });

  group('toJson', () {
    test('should return [json] with proper data', () {
      final res = tMovieDetailsModel.toJson();
      final expectedJson = jsonEncode(tMap);
      expect(res, equals(expectedJson));
    });
  });

  group('copyWith', () {
    test('should return [MovieDetailsModel] with new data', () {
      final res = tMovieDetailsModel.copyWith(originalTitle: "newtitle");
      expect(res.originalTitle, "newtitle");
    });
  });
}
