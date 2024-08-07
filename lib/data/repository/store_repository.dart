import 'package:mask_store_app/data/model/mask_store.dart';

abstract interface class StoreRepository {
  Future<List<MaskStore>> getStores();
}