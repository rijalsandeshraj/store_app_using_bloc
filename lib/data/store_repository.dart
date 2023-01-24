import 'dart:async';

import 'package:store_app_using_bloc/data/models/product.dart';

import 'store_api_provider.dart';

bool productsFetched = false;

class StoreRepository {
  static final StoreRepository _storeRepository = StoreRepository._();
  final storeApiProvider = StoreApiProvider();
  List<Product>? products;

  StoreRepository._();

  factory StoreRepository() {
    return _storeRepository;
  }

  // Gets all products from the API
  Future<void> getAllProducts() async {
    var data = await storeApiProvider.getAllProducts();
    products = data;
    productsFetched = true;
  }

  get allProducts {
    return products;
  }
}
