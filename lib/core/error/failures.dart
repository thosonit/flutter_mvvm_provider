import 'package:equatable/equatable.dart'; // Optional: for value equality

// Base Failure class
abstract class Failure extends Equatable {
  final String message;
  // You could add more properties like statusCode, stackTrace etc.

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message; // Simple representation
}

// Specific Failure types (examples)
class ServerFailure extends Failure {
  const ServerFailure({String message = 'An API error occurred'}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Could not connect to the network'}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Could not access local cache'}) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'The requested item was not found'}) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String message = 'An unexpected error occurred'}) : super(message);
}

// Helper function to map exceptions to Failures (optional but useful)
Failure mapExceptionToFailure(dynamic e) {
  // Add more specific exception handling (e.g., for DioError, SocketException)
  if (e is FormatException) {
    return const ServerFailure(message: 'Bad response format from server');
  }
  // Add more checks based on the exceptions your ApiClient might throw
  // For example, if ApiClient throws specific exceptions for status codes:
  // if (e is NotFoundException) return const NotFoundFailure();
  // if (e is NetworkException) return const NetworkFailure();

  print("Caught unmapped exception: $e \nStackTrace: ${e is Error ? e.stackTrace : ''}");
  return UnexpectedFailure(message: e.toString());
}