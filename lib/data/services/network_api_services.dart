import 'dart:convert';
import 'dart:io';
import 'package:ecom_app/data/exceptions/app_exception.dart';
import 'package:ecom_app/data/services/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiService {
  @override
  Future get(String url) async {
    final response;
    try {
      response = await http.get(Uri.parse(url));
    } on SocketException {
      throw FetchDataException(message: "Error During Communication");
    }
    return responseJson(response);
  }

  @override
  Future post(String url, data) async {
    final response;
    try {
      response = await http.post(Uri.parse(url), body: data);
    } on SocketException {
      throw FetchDataException(message: "Error During Communication");
    }
    return responseJson(response);
  }

  responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException();

      case 401:
        throw UnauthorizedException(message: "UnAuthorised Exception");

      case 500:
      case 502:
      case 503:
      case 504:
        throw InternalServerException(message: "Internal Server Exception");

      default:
        throw FetchDataException(
          message: "Unexpected error occurred [${response.statusCode}]",
        );
    }
  }
}
