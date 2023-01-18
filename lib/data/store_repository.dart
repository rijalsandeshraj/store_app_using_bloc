import 'dart:async';

import 'package:store_app_using_bloc/data/models/product.dart';

import 'store_api_provider.dart';

class StoreRepository {
  static final StoreRepository _storeRepository = StoreRepository._();
  final storeApiProvider = StoreApiProvider();

  StoreRepository._();

  factory StoreRepository() {
    return _storeRepository;
  }

  // Gets all products from the API
  Future<List<Product>?> getAllProducts() async =>
      await storeApiProvider.getAllProducts();

  get allProducts {
    getAllProducts();
  }
}
