import 'package:equatable/equatable.dart';
import 'package:sendapp/model/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final UserModel user;
  Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class Registration extends AuthenticationState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
