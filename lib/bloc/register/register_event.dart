import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class ButtonPressed extends RegisterEvent{
  final String name;
  final String email;
  final String lastName;

  ButtonPressed({this.name, this.email,  this.lastName});
  @override
  // TODO: implement props
  List<Object> get props => [name,email,lastName,];


}