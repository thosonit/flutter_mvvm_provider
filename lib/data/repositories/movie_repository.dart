import 'package:dartz/dartz.dart';
import 'package:flutter_app/core/configs/app_configs.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/network/api_client.dart';
import 'package:flutter_app/data/models/entities/movie_entity.dart';
import 'package:flutter_app/data/models/response/array_response.dart';

import '../../core/utils/logger.dart';

// --- Repository Interface ---
/// Abstract class defining the contract for movie data operations.
/// Uses Either<Failure, T> for robust error handling.
abstract class MovieRepository {
  /// Fetches a list of movies, typically paginated.
  ///
  /// Returns [Right<ArrayResponse<MovieEntity>>] on success.
  /// Returns [Left<Failure>] on failure (e.g., network, server error).
  Future<Either<Failure, ArrayResponse<MovieEntity>>> getMovies(
      {required int page});

  /// Fetches detailed information for a specific movie.
  ///
  /// Returns [Right<MovieEntity>] on success.
  /// Returns [Left<Failure>] on failure, including [NotFoundFailure] if the movie doesn't exist.
  Future<Either<Failure, MovieEntity>> getDetailMovie({required int id});
}

// --- Repository Implementation ---
/// Concrete implementation of the [MovieRepository] using Either for error handling.
class MovieRepositoryImpl implements MovieRepository {
  final ApiClient apiClient;

  MovieRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, MovieEntity>> getDetailMovie({required int id}) async {
    try {
      // Assume apiClient.getDetailMovie might return null for 404 or throw for other errors
      final movie = await apiClient.getDetailMovie(MovieAPIConfig.apiKey, id);

      // Success: return the movie wrapped in Right
      return Right(movie);
    } catch (e) {
      // Handle exceptions thrown by the ApiClient
      // Map the exception to a specific Failure type
      // You might need more sophisticated error mapping based on exception types
      // (e.g., check for SocketException, DioError, etc.)
      logger.e('Error fetching detail movie $id: $e'); // Log the error
      return Left(mapExceptionToFailure(e)); // Use helper or map directly
      // Example direct mapping:
      // return const Left(ServerFailure(message: 'Failed to fetch movie details'));
    }
  }

  @override
  Future<Either<Failure, ArrayResponse<MovieEntity>>> getMovies(
      {required int page}) async {
    try {
      // Assume apiClient.getMovies throws exceptions on failure
      final response = await apiClient.getMovies(MovieAPIConfig.apiKey, page);
      // Success: return the response wrapped in Right
      return Right(response);
    } catch (e) {
      // Handle exceptions thrown by the ApiClient
      logger.e('Error fetching movies page $page: $e'); // Log the error
      return Left(mapExceptionToFailure(e)); // Use helper or map directly
      // Example direct mapping:
      // return const Left(ServerFailure(message: 'Failed to fetch movies list'));
    }
  }
}
