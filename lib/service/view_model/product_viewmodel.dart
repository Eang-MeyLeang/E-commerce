import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/service/repository/product_repo.dart';
import 'package:e_commerce_app/service/utility/api_response.dart';
import 'package:flutter/material.dart';

class ProductViewModel  extends ChangeNotifier{
  final _productRepo = ProductRepo();
  ApiResponse<ProductModel> response = ApiResponse.LOADING();
  var searchRespone = ApiResponse();
  var deleteResponse = ApiResponse();
  

   setProductList(response) {
    this.response = response;
    notifyListeners();
  }

  setDeleteResponse(response) {
    this.deleteResponse = response;
    notifyListeners();
  }
   

  Future<dynamic> deleteProduct(id) async {
    await _productRepo.deleteProduct(id)
        .then((data) => setDeleteResponse(ApiResponse.COMPLETED(data)))
        .onError((error, stackTrace) => setDeleteResponse(ApiResponse.ERROR(stackTrace.toString())));
  }


  Future<dynamic> getAllProduct() async {
    await _productRepo.getProduct()
        .then((product) => 
         setProductList(ApiResponse.COMPLETED(product) ))
        .onError((error, stackTrace)
                  => setProductList(ApiResponse.ERROR(stackTrace.toString())));
  }

}