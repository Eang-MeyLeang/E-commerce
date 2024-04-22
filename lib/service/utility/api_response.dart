import 'package:e_commerce_app/service/utility/status.dart';

class ApiResponse<T>{
  Status? status;
  T? data;
  String? message;

  ApiResponse({this.status,this.data,this.message});
  ApiResponse.LOADING() : status = Status.LOADING;
  ApiResponse.COMPLETED(this.data) : status = Status.COMPLETED;
  ApiResponse.ERROR(this.message) : status = Status.ERROR;
}