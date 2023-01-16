import 'dart:async';

import 'package:store_app_using_bloc/data/models/product.dart';

import 'store_api_provider.dart';

class StoreRepository {
  final storeApiProvider = StoreApiProvider();

  // Gets all products from the API
  Future<List<Product>?> getAllProducts() => storeApiProvider.getAllProducts();
}
