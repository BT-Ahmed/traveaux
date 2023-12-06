import 'package:geolocator/geolocator.dart';

// A class to handle the location logic
class LocationService {
  // A method to get the current location of the user
  Future<Position> getCurrentLocation() async {
    // Check if the location service is enabled
    final enabled = await Geolocator.isLocationServiceEnabled();
    // If the location service is not enabled, throw an exception
    if (!enabled) {
      throw Exception('Please enable the location service.');
    }
    // Otherwise, request the location permission
    final permission = await Geolocator.requestPermission();
    // Check if the permission is granted
    final granted = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
    // If the permission is not granted, throw an exception
    if (!granted) {
      throw Exception('Please grant the location permission.');
    }
    // Otherwise, get the current position of the user
    final position = await Geolocator.getCurrentPosition();
    // Return the position
    return position;
  }
}
