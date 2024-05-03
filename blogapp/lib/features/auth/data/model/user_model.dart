import 'package:blogapp/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromjson(Map<String, dynamic> map) {

  
    return UserModel(
      id: map["id"]??"",
      email: map["email"]??"",
      name: map["name"]??"",
    );
  }
}
