import 'package:e_commerce_app/model/category_model.dart';
import 'package:e_commerce_app/service/repository/category_repo.dart';
import 'package:e_commerce_app/service/utility/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final _categoryRepo = CategoryRepo();
  ApiResponse<CategoryModel> response = ApiResponse.LOADING();

  setCategoryList( response) {
    this.response = response;
   // print('VM : ${response}');
    notifyListeners();
  }

 Future<dynamic> getAllCategory() async {
    await _categoryRepo.getCategory()
        .then((category) => 
         setCategoryList(ApiResponse.COMPLETED(category)
         ))
        .onError((error, stackTrace)
                  => setCategoryList(ApiResponse.ERROR(stackTrace.toString())));
  }
}
