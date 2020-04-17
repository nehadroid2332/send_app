import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:sendapp/model/address.dart';

import 'helpers/api_base_helper.dart';
import 'helpers/api_response.dart';

class NetworkRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<ApiResponse> getCategories() async {
    try {
      Map<String, dynamic> apiResponse = await _helper.getReq(
        url: "categoryList",
      );
      return ApiResponse.completed(apiResponse);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> addAddress({Map address}) async {
    try {
      Map<String, dynamic> apiResponse =
          await _helper.postReq(url: "addressAdd", body: address);
      return ApiResponse.completed(apiResponse);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> getProducts({String id,LocationData position}) async {


    try {
      Map<String, dynamic> apiResponse = await _helper.postReq(
          url: "productList",
          body: {
            "id": id,
            //fixme: remove hard code coordinates
            "lat": position.latitude,
            "long": position.longitude
          });
      return ApiResponse.completed(apiResponse);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> loadAddress({String userId}) async {
    try {
      Map<String, dynamic> apiResponse =
          await _helper.postReq(url: "addressList", body: {"userId": userId});
      return ApiResponse.completed(apiResponse);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> verifyUser({ String phone})async {
    try {
     final val = FirebaseMessaging();
     val.getToken();
      Map<String, dynamic> apiResponse =
      await _helper.postReq(url: "login", body: {"phone":phone});
//      await _helper.postReq(url: "login", body: {"phone": await val.getToken()});
      return ApiResponse.completed(apiResponse);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> registerUser(
      {String name, String email, String lastName, String phone}) async{
    try {

      Map<String, dynamic> apiResponse =
      await _helper.postReq(url: "registration", body: {"firstName": name,"lastName":lastName,"email":email,"phone":phone});
      return ApiResponse.completed(apiResponse);
    }  catch (e) {
      print("netwoek me hu");
      throw e;
    }
  }
}
