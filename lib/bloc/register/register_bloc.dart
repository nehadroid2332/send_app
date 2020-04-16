import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_bloc.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/services/user_repo.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepo repo;
  final AuthenticationBloc authBloc;

  RegisterBloc({@required this.repo,this.authBloc});
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is ButtonPressed){
yield*      _mapButtonPressToStaet(event);
    }
  }

  Stream<RegisterState> _mapButtonPressToStaet(ButtonPressed event)async*{
try {
  yield UserRegistering();
  final user = await repo.registerUser(email: event.email,name: event.name,lname: event.lastName);
 print(user);
  repo.saveUser(user);

  yield UserRegistered(user: user);
} catch (e) {
  print(e);
  yield UserRegisterFail(reason: e.toString());
}
  }
}
