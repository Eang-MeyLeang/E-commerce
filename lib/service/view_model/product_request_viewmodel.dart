import 'package:e_commerce_app/service/repository/product_repo.dart';
import 'package:e_commerce_app/service/utility/api_response.dart';
import 'package:flutter/material.dart';

class ProductRequestViewmodel extends ChangeNotifier{
  final _productRepo = ProductRepo();
  var response = ApiResponse();

  setRestaurantData(response){
    this.response = response;
    notifyListeners();
  }

  Future<dynamic> postProduct(data, {isUpdate, id}) async{
    setRestaurantData(ApiResponse.LOADING());
    await _productRepo.postProduct(data, isUpdate: isUpdate, id: id)
        .then((isPosted) => setRestaurantData(ApiResponse.COMPLETED(isPosted)))
        .onError((error, stackTrace) => setRestaurantData(ApiResponse.ERROR(stackTrace.toString())));
  }
}