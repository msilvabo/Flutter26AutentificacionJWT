import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslo_shop/features/auth/domain/entities/auth_state.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure.dart';

import '../../domain/entities/user.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  final authReposity = AuthRepositoryImpl();

  @override
  AuthState build() => AuthState();

  void loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authReposity.login(email, password);
      _setLoggerUser(user);
    } on WrongCredentials{
        logout("Credencialesno son correctas");
    }
      catch (e) {
        logout("Error no controlado");
    }
  }

  void registerUser(String email, String password) async {}
  void checkAuthStatus() async {}

  Future<void> logout([String? errorMessage]) async {
    //TODO limpiar token
    state = state.copyWith(
        authStatus: AuthStatus.notAuthentucated,
        user: null,
        errorMessage: errorMessage);
  }

  void _setLoggerUser(User user) {
    //TODO: guardar token en dispositivo
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }
}
