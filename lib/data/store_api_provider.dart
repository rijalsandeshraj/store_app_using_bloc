import 'package:store_app_using_bloc/core/constants/api_endpoints.dart';
import 'package:store_app_using_bloc/data/models/product.dart';

import 'api_services.dart';

class StoreApiProvider {
  ApiServices api = ApiServices();

  Future<List<Product>?> getAllProducts() async {
    var url = ApiUrl.allProductsUrl;
    var response = await api.get(url);
    if (response != null) {
      List<Product> products = [];
      for (var element in response) {
        products.add(Product.fromJson(element));
      }
      // List<Product> products =
      //     response.map((e) => Product.fromJson(e)).toList();
      return products;
    }
    return null;
  }
}
