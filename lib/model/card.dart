import 'package:equatable/equatable.dart';

class CardDetails extends Equatable{
  String name;
  String number;
  String expiry;
  int code;
  int type;
  CardDetails(String name, String number, String expiry, int code, int type) {
    this.name = name;
    this.number = number;
    this.expiry = expiry;
    this.code = code;
    this.type = type;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name,number,expiry,code,type];
}
