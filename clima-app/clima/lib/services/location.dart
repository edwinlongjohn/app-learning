import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  bool error = false;
  late double longitude;
  late String errorText;

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool isAlllowed = true;
    if (permission == LocationPermission.denied) {
      isAlllowed = false;
    }
    return isAlllowed;
  }

  Future<void> getCurrentLocation() async {
    final permission = await _checkPermission();
    if (!permission) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse) {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low);
          latitude = position.latitude;
          longitude = position.longitude;
        } catch (e) {
          error = true;
          errorText = 'something went wrong';
        }
      }
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        error = true;
        errorText = 'something went wrong';
      }
    }
  }
}
