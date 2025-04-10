class Logger {
  // Private constructor to prevent instantiation.
  Logger._();

  /// Logs a regular message.
  static void log(String message) {
    // You may expand this to log to a file or external service.
    print("[LOG] $message");
  }

  /// Logs an error message along with an optional exception.
  static void error(String message, [Exception? e]) {
    print("[ERROR] $message ${e?.toString() ?? ''}");
  }
}
