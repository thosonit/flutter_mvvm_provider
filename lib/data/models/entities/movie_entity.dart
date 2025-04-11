import 'package:json_annotation/json_annotation.dart';

class MovieEntity {
  int id;
  String title;
  String? posterPath;
  String? backdropPath;
  double? voteAverage;
  String? originalTitle;
  String? overview;
  String? releaseDate;

  MovieEntity({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.originalTitle,
    this.overview,
    this.releaseDate,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'original_title': originalTitle,
      'overview': overview,
      'release_date': releaseDate,
    };
  }

  String get posterUrl {
    return 'https://image.tmdb.org/t/p/w500${posterPath ?? ""}';
  }

  String get posterPathUrl {
    return 'https://image.tmdb.org/t/p/original${posterPath ?? ""}';
  }
}
