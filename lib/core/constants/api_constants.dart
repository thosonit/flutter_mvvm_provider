class ApiConstants {
  ApiConstants._(); // Private constructor

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String productsEndpoint = '/products';
  static const String profileEndpoint = '/user/profile';

  // Timeouts (in milliseconds)
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

// Headers (Example - API keys should NOT be here in real code)
// static const String apiKeyHeader = 'X-Api-Key';
// static const String fakeApiKey = 'your_api_key_here'; // !! DON'T DO THIS IN PRODUCTION
}
