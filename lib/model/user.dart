// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);


class UserModel {
  final String role;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String status;

  UserModel({
    this.role,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.status,
  });

  UserModel copyWith({
    String role,
    String id,
    String firstName,
    String lastName,
    String email,
    String phone,
    String status,
  }) =>
      UserModel(
        role: role ?? this.role,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        status: status ?? this.status,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    role: json["role"],
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "status": status,
  };
}
