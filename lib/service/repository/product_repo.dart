import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/model/product_request_model.dart';
import 'package:e_commerce_app/service/network/api_service.dart';
import 'package:e_commerce_app/service/utility/app_url.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  Future<ProductModel> getProduct() async {
    try {
      dynamic response = await _apiService.getApi(AppUrl.getProduct);
      //print(' product repo : ${response}');
      //var responseJson = ProductModel.fromJson(jsonDecode(response));
      return productModelFromJson(response);
    } catch (exception) {
      print('exception $exception');
      rethrow;
    }
  }

  Future<bool> postProduct(data, {isUpdate, id}) async {
    print('product id $id');
    var productRequest = productRequestModelToJson(data);
    var url = isUpdate ? '${AppUrl.PostProduct}/$id' : AppUrl.PostProduct;
    dynamic response =
        await _apiService.postProduct(url, productRequest, isUpdate);
    return response;
  }

  Future<dynamic> deleteProduct(id) async {
    dynamic response =
        await _apiService.deleteProduct('${AppUrl.PostProduct}/$id');
    return response;
  }
}
