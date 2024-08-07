import 'package:mask_store_app/data/model/location.dart';
import 'package:mask_store_app/data/repository/location_repository.dart';

class MockLocationRepository implements LocationRepository {
  @override
  double distanceBetween(
      double startLat, double startLng, double endLat, double endLng) {
    return 0;
  }

  @override
  Future<Location> getLocation() async {
    return const Location(latitude: 0, longitude: 0);
  }
}
