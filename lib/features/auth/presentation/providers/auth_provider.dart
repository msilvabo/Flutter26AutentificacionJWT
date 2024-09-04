import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslo_shop/features/auth/domain/entities/auth_state.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {

  final authReposity = AuthRepositoryImpl();

  @override
  AuthState build() => AuthState();

  void loginUser(String email, String password) async {
    
    // final user = await authReposity.login(email, password);
    // state.copyWith(
    //   user: user,
    //   authStatus: AuthStatus.authenticated
    //   );
  }

  void registerUser(String email, String password) async {}
  void checkAuthStatus() async {}
}
