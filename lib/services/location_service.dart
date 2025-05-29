import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../dtos/response/location_data.dart';

class LocationService {
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position> getCurrentPosition() async {
    bool isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw Exception('Location services are disabled');
    }
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission are denied');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<LocationData> getLocationData() async {
    final Position position = await getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if(placemarks.isEmpty)
      throw Exception('Could not get address from coordinates');

    final locationData = LocationData();
    locationData.latitude = position.latitude;
    locationData.longitude = position.longitude;
    locationData.city = placemarks[0].locality!;
    locationData.country = placemarks[0].country!;
    return locationData;
  }
}
