import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class ObjectResponse<T> {
  final String message;
  final T? data;

  ObjectResponse({
    this.message = "",
    this.data,
  });

  factory ObjectResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      ObjectResponse<T>(
        message: json['message'] as String? ?? '',
        data: _$nullableGenericFromJson(json['data'], fromJsonT),
      );
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);
