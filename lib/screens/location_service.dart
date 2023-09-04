import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getLocation() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      try {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
      } catch (e) {
        throw Exception('Failed to get location: $e');
      }
    } else if (permissionStatus.isDenied) {
      throw Exception(
          'Location permission denied. Please enable it in app settings.');
    } else if (permissionStatus.isPermanentlyDenied) {
      throw Exception(
          'Location permission permanently denied. Please enable it in device settings.');
    }
    return null; // Handle other permission statuses if needed..
  }
}
