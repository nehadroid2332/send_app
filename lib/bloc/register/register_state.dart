import 'package:equatable/equatable.dart';
import 'package:sendapp/model/user.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class UserRegistered extends RegisterState{
  final UserModel user;
  UserRegistered({this.user});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserRegisterFail extends RegisterState{
  final String reason;
  UserRegisterFail({this.reason});
  @override
  // TODO: implement props
  List<Object> get props => [reason];
}

class UserRegistering extends RegisterState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}