import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class LoginFail extends LoginState{
  final String reason;

  LoginFail(this.reason);

  @override
  // TODO: implement props
  List<Object> get props => [reason];
}

class LogedIn extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}