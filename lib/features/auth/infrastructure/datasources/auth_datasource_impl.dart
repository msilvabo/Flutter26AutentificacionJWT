import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure.dart';

import '../../domain/domain.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiURL));

  @override
  Future<User> checkAuthStatus(String token) {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('auth/login', 
      data: {
        'email': email, 
        'password': password}
      );
      final User user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
        throw UnimplementedError();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }
}
