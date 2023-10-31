import 'package:flutter_example_test/network/DioRequest.dart';

class ApiService {
  static const brands_url = "app/v1/global/brands";

  static getBrands() async {
      var response = await DioRequest.getInstance().dio.get(brands_url);
      return response;
  }
}