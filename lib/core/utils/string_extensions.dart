extension StringExtensions on String {
  /// Capitalizes the first character of the string.
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Checks if the string is a valid email format.
  bool isValidEmail() {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(this);
  }
}
