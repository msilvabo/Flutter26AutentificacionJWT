import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:teslo_shop/features/shared/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/services/key_value_storage_service_impl.dart';

import '../../domain/entities/auth_state.dart';
import '../../infrastructure/errors/auth_errors.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();


  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});



class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super( AuthState() ) {
    checkAuthStatus();
  }
  

  Future<void> loginUser( String email, String password ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout( e.message );
    } catch (e){
      logout( 'Error no controlado' );
    }

    // final user = await authRepository.login(email, password);
    // state =state.copyWith(user: user, authStatus: AuthStatus.authenticated)

  }

  void registerUser( String email, String password ) async {
    
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if( token == null ) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);

    } catch (e) {
      logout();
    }

  }

  void _setLoggedUser( User user ) async {
    
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }

}
