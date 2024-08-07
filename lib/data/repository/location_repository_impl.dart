import 'package:geolocator/geolocator.dart';
import 'package:mask_store_app/data/model/location.dart';
import 'package:mask_store_app/data/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  double distanceBetween(
          double startLat, double startLng, double endLat, double endLng) =>
      Geolocator.distanceBetween(startLat, startLng, endLat, endLng);

  @override
  Future<Location> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        return const Location(latitude: 0, longitude: 0);
      } else if (permission == LocationPermission.deniedForever) {
        return const Location(latitude: 0, longitude: 0);
      }

      // 승인
      final position = await Geolocator.getCurrentPosition();
      return Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }

    return const Location(latitude: 0, longitude: 0);
  }
}
