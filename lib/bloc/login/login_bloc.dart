import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/utils/validators.dart';
import './bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo _userRepository;

  LoginBloc({
    @required UserRepo userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => InitialLoginState();



  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
 if (event is LoginWithPhonePressed) {
      yield* _mapLoginWithPhonePressedToState(
          smsCode: event.smsCode, verificationCode: event.verificationCode);
    }
  }

//  Stream<LoginState> _mapPhoneChangedToState(String phone) async* {
//    yield state.update(
//      isPhoneValid: phone.length == 10,
//    );
//  }

//  Stream<LoginState> _mapEmailChangedToState(String email) async* {
//    yield state.update(
//      isEmailValid: Validators.isValidEmail(email),
//    );
//  }
//
//  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
//    yield state.update(
//      isPasswordValid: Validators.isValidPassword(password),
//    );
//  }

//  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
//    try {
//      await _userRepository.signInWithGoogle();
//      yield LoginState.success();
//    } on PlatformException catch (e) {
//      yield LoginState.failure(e.message);
//    }
//  }

//  Stream<LoginState> _mapLoginWithFacebookPressed() async* {
//    try {
//      var user = await _userRepository.signInWithFacebook();
//      print("Cheking for $user");
//      if (user != null) {
//        yield LoginState.success();
//      } else {
//        yield LoginState.failure("Cancelled by user");
//      }
//    } on PlatformException catch (e) {
//      yield LoginState.failure(e.message);
//    }
//  }

//  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
//    String email,
//    String password,
//  }) async* {
//    yield LoginState.loading();
//    try {
//      await _userRepository.signInWithCredentials(email, password);
//      yield LoginState.success();
//    } on PlatformException catch (e) {
//      yield LoginState.failure(e.message);
//    }
//  }

  // Stream<LoginState> _mapSendVerificationCodePressedToState({
  //   String phone,
  // }) async* {
  //   yield LoginState.loading();
  //   try {
  //     await _userRepository.verifyPhone(phone);
  //     // yield LoginState.success();
  //     print("PASSED");
  //   } catch (e) {
  //     print("FAILED");
  //     yield LoginState.failure(e.message);
  //   }
  // }

  Stream<LoginState> _mapLoginWithPhonePressedToState(
      {String smsCode, String verificationCode}) async* {
    print("$smsCode and $verificationCode");
    yield LoginLoading();
    try {
   final  FirebaseUser user= await _userRepository.signInWithPhone(smsCode, verificationCode);
user!=null?    await _userRepository.saveUser(UserModel(id: user.uid,phone: user.phoneNumber)):null;
      yield LogedIn();
    }  catch (e) {
      yield LoginFail(e.message);
    }
  }
}
