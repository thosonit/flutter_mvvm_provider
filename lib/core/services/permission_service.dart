import 'package:permission_handler/permission_handler.dart';

/// PermissionService handles permission requests and checks,
/// making it simpler to manage app permissions from a centralized service.
class PermissionService {
  // Private constructor for singleton pattern.
  PermissionService._privateConstructor();

  // Singleton instance.
  static final PermissionService _instance =
      PermissionService._privateConstructor();

  // Factory constructor returns the singleton instance.
  factory PermissionService() {
    return _instance;
  }

  /// Requests location permission and returns true if granted.
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  /// Checks if the camera permission is granted.
  Future<bool> isCameraPermissionGranted() async {
    return await Permission.camera.isGranted;
  }
}
