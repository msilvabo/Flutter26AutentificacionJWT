import 'package:teslo_shop/features/shared/shared.dart';

class ScreenFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final Email email;
  final Password password;

  ScreenFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.fullName = const FullName.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  @override
  String toString() {
    return '''
    LoginFormState:
      isFormPosted: $isFormPosted
      isPosting: $isPosting
      isValid: $isValid
      fullname: $fullName
      email: $email
      password: $password
    ''';
  }

  ScreenFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          FullName? fullName,
          Email? email,
          Password? password
          }) =>
      ScreenFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password
      );
}
