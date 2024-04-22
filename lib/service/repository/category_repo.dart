import 'dart:convert';
import 'package:e_commerce_app/model/category_model.dart';
import 'package:e_commerce_app/service/network/api_service.dart';
import 'package:e_commerce_app/service/utility/app_url.dart';

class CategoryRepo {

  final ApiService _apiService = ApiService();

    Future<CategoryModel> getCategory() async{
    try{
      dynamic response = await _apiService.getApi(AppUrl.getAllCategory);
      //print('repo : ${response}');
      var responseJson = CategoryModel.fromJson(jsonDecode(response));
      return responseJson;
      
    }catch(exception){
      print('exception $exception');
      rethrow;
    }
  }
}
