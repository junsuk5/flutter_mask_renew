import 'package:mask_store_app/data/model/location.dart';

abstract interface class LocationRepository {
  Future<Location> getLocation();

  double distanceBetween(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  );
}
