import 'dart:convert';

import 'package:sendapp/utils/constants.dart';

import 'app_exception.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
// final String _baseUrl = "http://31.220.53.71:1348/api/chef/"; //Live Url
  final String _baseUrl = Constants.URL+"user/"; //my ngrok

  Map<String, String> header = {};

  Future<dynamic> getReq({String url}) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      print(url);
      print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return jsonDecode(responseJson.body);
  }

  Future<dynamic> upload({String url, File file, String chefId}) async {
    http.Response responseJson;
    try {
      var request =
          await http.MultipartRequest("POST", Uri.parse(_baseUrl + url));
      request.files.add(
        http.MultipartFile.fromBytes("file", file.readAsBytesSync(),
            filename: file.path.split("/").last),
      );
      request.fields["chefId"] = chefId;
      var response = await request.send();
      var res = await http.Response.fromStream(response);
      responseJson = _returnResponse(res);
      return jsonDecode(responseJson.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postReq({String url, Map header, Map body}) async {
    http.Response responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          body: jsonEncode(body), headers: header ?? this.header);
print(body);
print(response.body);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return jsonDecode(responseJson.body);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        Map decodeBody = jsonDecode(response.body);
        if (decodeBody.containsValue("ERROR")) {
          throw ApiErrorException(decodeBody['message']);
        }
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 404:
        throw NotFound("404");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server: ${response.statusCode}');
    }
  }
}
