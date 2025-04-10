import 'package:dio/dio.dart';
import 'package:flutter_app/data/models/entities/movie_entity.dart';
import 'package:flutter_app/data/models/response/array_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// Movie
  @GET("/3/discover/movie")
  Future<ArrayResponse<MovieEntity>> getMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET("/3/movie/{id}")
  Future<MovieEntity> getDetailMovie(
    @Query('api_key') String apiKey,
    @Path('id') int id,
  );
}
