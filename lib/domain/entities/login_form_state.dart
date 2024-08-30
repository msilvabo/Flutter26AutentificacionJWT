import '../../features/shared/shared.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState(
      {this.isFormPosted = false,
      this.isPosting = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  @override
  String toString() {
    return '''
    LoginFormState:
      isFormPosted: $isFormPosted
      isPosting: $isPosting
      isValid: $isValid
      email: $email
      password: $password
''';
  }

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password
  }) => LoginFormState(
          isFormPosted : isFormPosted ?? this.isFormPosted,
          isPosting : isPosting ?? this.isPosting,
          isValid : isValid ?? this.isValid,
          email : email ?? this.email,
          password : password ?? this.password,
  );


}