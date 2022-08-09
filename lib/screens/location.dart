
import 'package:geolocator/geolocator.dart';

class Location {
  Location();
  double latitude = 0;
  double longitude = 0;
  Future<void> getlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}

