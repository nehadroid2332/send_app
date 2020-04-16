import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
//

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class NotRegistered extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}