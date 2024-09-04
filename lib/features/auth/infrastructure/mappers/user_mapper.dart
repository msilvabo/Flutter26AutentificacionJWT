import 'package:teslo_shop/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String,dynamic> json) => 
  User(
  id: json['id'],
  email: json['email'],
  fullName: json['fullName'],
  role: List<String>.from(json['role'].map((role) => role)),
  token: json['token']);
}