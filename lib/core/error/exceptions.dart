// Custom Exceptions

/// Exception thrown when a server error occurs.
class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server error']);

  @override
  String toString() => 'ServerException: $message';
}

/// Exception thrown when a cache (local data) error occurs.
class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error']);

  @override
  String toString() => 'CacheException: $message';
}
