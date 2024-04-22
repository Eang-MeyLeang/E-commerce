import 'package:e_commerce_app/model/image_model.dart';
import 'package:e_commerce_app/service/network/api_service.dart';
import 'package:e_commerce_app/service/utility/app_url.dart';

class ImageRepository {
  final _apiService = ApiService();

  Future<List<ImageModel>> uploadImage(image) async{
    var response = await _apiService.uploadImage(image, AppUrl.uploadImage);
    return imageModelFromJson(response);
  }

}