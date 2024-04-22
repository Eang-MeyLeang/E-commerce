import 'package:e_commerce_app/service/repository/image_repo.dart';
import 'package:e_commerce_app/service/utility/api_response.dart';
import 'package:flutter/material.dart';

class ImageViewModel extends ChangeNotifier {
  final _imageRepo = ImageRepository();
  ApiResponse<dynamic> response = ApiResponse();
  
  setImageData(response){
    this.response = response;
    print(response);
    notifyListeners();
  }

  Future<dynamic> uploadImage(image) async {
    setImageData(ApiResponse.LOADING());
    await _imageRepo.uploadImage(image)
        .then((imageList) => setImageData(ApiResponse.COMPLETED(imageList)))
        .onError((error, stackTrace) => setImageData(ApiResponse.ERROR(stackTrace.toString())));
  }
}