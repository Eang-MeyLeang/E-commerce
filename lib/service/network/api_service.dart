import 'dart:io';
import 'package:e_commerce_app/service/utility/app_exception.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> getApi(url) async {
    http.StreamedResponse? response;
    try {
      var request = http.Request('GET', Uri.parse(url));
      response = await request.send();
      //print('print api ${ await response.stream.bytesToString()}');

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException(response!.reasonPhrase.toString());
    }
  }

  Future<dynamic> postProduct(url, data, bool isUpdate) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(isUpdate ? 'PUT' : 'POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> uploadImage(image, url) async {
    http.StreamedResponse? response;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('files', image));
      response = await request.send();
      return returnResponse(response);
    } on Exception {
      throw FetchDataException(response!.reasonPhrase);
    }
  }

  Future<dynamic> deleteProduct(url) async {
    var request = http.Request('DELETE', Uri.parse(url));

    var response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  returnResponse(http.StreamedResponse response) async {
    // print('response ${response.reasonPhrase}');
    //print('response ${response.stream.bytesToString()}');
    switch (response.statusCode) {
      case 200:
        print(response.reasonPhrase);
        return await response.stream.bytesToString();
      case 400:
        throw FetchDataException('No Internet Connection');
    }
  }
}
