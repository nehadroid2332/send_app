import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:sendapp/model/address.dart';
import 'package:sendapp/model/order_model.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/services/network_repository.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:sendapp/utils/sharedPreferenceUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart';

class UserRepo {
  final FirebaseAuth _firebaseAuth;


  UserRepo({
    FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  SharedPreferences _sharedPreferences;
  UserModel user;
  Future<bool> isSignedIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(Constants.SIGNIN) ?? false;
  }


List<Token> _savedCard = [];

  List<Token> get savedCard => _savedCard;

  List<Address> _addresses = [];
  Address _address;

  Address get address => _address;

  set address(Address value) {
    _address = value;
  }

  OrderModel _orderModel;

  OrderModel get orderModel => _orderModel;

 set orderModel(OrderModel value) {
    _orderModel = value;
  }

  List<Address> get addresses => _addresses;
  NetworkRepository _networkRepository = NetworkRepository();
  final String userId = "5d67f7ae-65d6-4653-b311-7249f33bb0aa";

  Future<String> getUserId()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  final user = UserModel.fromJson(
        jsonDecode(_sharedPreferences.getString(Constants.USER)));
  return user.id;
  }

//add address
  Future<Address> addUserAddress({String name, String address, String pinCode}) async {
    print("inside Function");
    try {
      var location = await Location.instance.getLocation();
      Map body = {"userId":await getUserId(),"type":"Home","address":address,"postalCode":pinCode,"isDefault":"1","lat":location.latitude,"long":location.longitude};
      final res = await _networkRepository.addAddress(address: body);
     _address= Address.fromJson(res.data["data"]);
      _addresses.add(Address.fromJson(res.data["data"]));
      return Address.fromJson(res.data["data"]);
    } catch (e) {
      throw e;
    }
  }

//fetch address List
  Future<List<Address>> loadAddresses() async {
    final res = await _networkRepository.loadAddress(userId: userId);
    final List address = res.data["data"] as List;
    return address.map((e) => Address.fromJson(e)).toList();
  }


//to sign out
  Future <void> signOut() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }

//login with Phone
  Future<FirebaseUser> signInWithPhone(String smsCode,
      String verificationCode) async {
    await _firebaseAuth.signOut();
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationCode,
      smsCode: smsCode,
    );

    await _firebaseAuth.signInWithCredential(credential);

    return _firebaseAuth.currentUser();
  }



  Future verifyCurrentUser({ String phoneNumber}) async {
    try {
      var res =
      await _networkRepository.verifyUser(phone: phoneNumber,);
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setBool(Constants.SIGNIN, true);
      saveUser(UserModel.fromJson(res.data["data"]));
      return UserModel.fromJson(res.data["data"]);
    } catch (e) {
      print(e);
      throw e;
    }
  }

//save user
  Future<void> saveUser(UserModel model) async {
    user = model;
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(Constants.USER, jsonEncode(model.toJson()));
  }

//get current user
  Future<UserModel> getSavedUser() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return UserModel.fromJson(
        jsonDecode(_sharedPreferences.getString(Constants.USER)));
  }


  Future<UserModel> registerUser(
      {String name, String lname, String email}) async {
    try {
      UserModel user = await getSavedUser();
      var res = await _networkRepository.registerUser(
          phone: user.phone, email: email, lastName: lname, name: name);
      user = UserModel.fromJson(res.data["data"]);
      saveUser(user);
      _sharedPreferences.setBool(Constants.SIGNIN, true);
      return UserModel.fromJson(res.data["data"]);
    } catch (e) {
      print(e);
      throw e;
    }
  }

}
