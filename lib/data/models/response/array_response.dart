import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class ArrayResponse<T> {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<T> results;

  ArrayResponse({
    this.page = 1,
    this.totalPages = 0,
    this.totalResults = 0,
    this.results = const [],
  });

  factory ArrayResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      ArrayResponse<T>(
        page: json['page'] as int? ?? 1,
        totalPages: json['total_pages'] as int? ?? 0,
        totalResults: json['total_results'] as int? ?? 0,
        results:
            (json['results'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
      );
}
