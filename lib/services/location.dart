import 'package:geolocator/geolocator.dart';

class MyLocation {
  Future<List<String>> determinePosition() async {
    final bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied,'
        'we cannot request permissions.',
      );
    }

    final Position position = await Geolocator.getCurrentPosition();
    final String latitude = position.latitude.toString();
    final String longitude = position.longitude.toString();

    return <String>[latitude, longitude];
  }
}
