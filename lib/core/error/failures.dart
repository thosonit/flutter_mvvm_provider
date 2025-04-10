// Failure classes for business logic

/// Abstract class representing a generic failure.
abstract class Failure {
  final String message;

  Failure(this.message);
}

/// Failure for server-related errors.
class ServerFailure extends Failure {
  ServerFailure([String message = 'Server failure']) : super(message);
}

/// Failure for cache-related errors.
class CacheFailure extends Failure {
  CacheFailure([String message = 'Cache failure']) : super(message);
}
