/// Enum representing the status of a loading operation.
///
/// This is used to track the state of asynchronous operations
/// such as fetching data from a repository or API.
enum LoadStatus {
  /// The initial state before any operation has started.
  initial,

  /// Indicates that the operation is currently in progress.
  loading,

  /// Indicates that the operation completed successfully.
  success,

  /// Indicates that the operation failed.
  failure,
}
