import 'package:equatable/equatable.dart';

class CardDetails extends Equatable {
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
  List<Object> get props => [name, number, expiry, code, type];
}

class Token extends Equatable {
  String id;
  String object;
  BillingDetails billingDetails;
  Card card;
  int created;
  bool livemode;
  String type;

  Token(
      {this.id,
      this.object,
      this.billingDetails,
      this.card,
      this.created,
      this.livemode,
      this.type});

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    billingDetails = json['billing_details'] != null
        ? new BillingDetails.fromJson(json['billing_details'])
        : null;
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    created = json['created'];
    livemode = json['livemode'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    if (this.billingDetails != null) {
      data['billing_details'] = this.billingDetails.toJson();
    }
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    data['created'] = this.created;
    data['livemode'] = this.livemode;
    data['type'] = this.type;
    return data;
  }

  @override
  List<Object> get props => [id];
}

class BillingDetails {
  Address address;
  String email;
  String name;
  String phone;

  BillingDetails({this.address, this.email, this.name, this.phone});

  BillingDetails.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  String city;
  String country;
  String line1;
  String line2;
  String postalCode;
  String state;

  Address(
      {this.city,
      this.country,
      this.line1,
      this.line2,
      this.postalCode,
      this.state});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    line1 = json['line1'];
    line2 = json['line2'];
    postalCode = json['postal_code'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['postal_code'] = this.postalCode;
    data['state'] = this.state;
    return data;
  }
}

class Card {
  String brand;
  String country;
  int expMonth;
  int expYear;
  String funding;
  String last4;

  Card(
      {this.brand,
      this.country,
      this.expMonth,
      this.expYear,
      this.funding,
      this.last4});

  Card.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    country = json['country'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    funding = json['funding'];
    last4 = json['last4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['country'] = this.country;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['funding'] = this.funding;
    data['last4'] = this.last4;
    return data;
  }
}
