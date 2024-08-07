import 'package:flutter/material.dart';
import 'package:mask_store_app/data/model/mask_store.dart';
import 'package:mask_store_app/data/repository/location_repository.dart';
import 'package:mask_store_app/data/repository/store_repository.dart';

class MainViewModel with ChangeNotifier {
  final StoreRepository _storeRepository;
  final LocationRepository _locationRepository;

  MainViewModel({
    required StoreRepository storeRepository,
    required LocationRepository locationRepository,
  })  : _storeRepository = storeRepository,
        _locationRepository = locationRepository {
    fetchStores();
  }

  // 상태
  List<MaskStore> _stores = [];
  bool _isLoading = false;

  List<MaskStore> get stores => List.unmodifiable(_stores);

  bool get isLoading => _isLoading;

  void fetchStores() async {
    _isLoading = true;
    notifyListeners();

    final stores = await _storeRepository.getStores();
    final location = await _locationRepository.getLocation();

    for (var store in stores) {
      store.distance = _locationRepository.distanceBetween(
        store.latitude,
        store.longitude,
        location.latitude,
        location.longitude,
      );
    }

    stores.sort((a, b) => a.distance.compareTo(b.distance));

    _stores = stores;
    _isLoading = false;
    notifyListeners();
  }
}
