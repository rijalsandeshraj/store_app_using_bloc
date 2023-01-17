import 'package:store_app_using_bloc/core/constants/api_endpoints.dart';
import 'package:store_app_using_bloc/data/models/product.dart';

import 'api_services.dart';
import 'models/mobile_response.dart';

class StoreApiProvider {
  ApiServices api = ApiServices();

  Future<List<Product>?> getAllProducts() async {
    var url = ApiUrl.allProductsUrl;
    var result = await api.get(url);
    if (result != null) {
      var response = MobileResponse<List<Product>>.fromJson(result, (json) {
        List data = json;
        List<Product> dataList = data.map((i) => Product.fromJson(i)).toList();
        return dataList;
      });
      return response.data;
    }
    return null;
  }
}
