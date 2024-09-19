import 'package:formz/formz.dart';

enum FullNameError { empty, length }

class FullName extends FormzInput<String, FullNameError> {
  static final RegExp fullNameExp = RegExp(r'^.{5,}$');

  const FullName.pure() : super.pure('');

  const FullName.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == FullNameError.empty) return 'El campo es requerido';
    if (displayError == FullNameError.length) return 'minimo requerido 5 caracteres';

    return null;
  }

  @override
  FullNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return FullNameError.empty;
    if (value.length < 5) return FullNameError.length;
    return null;
  }
}
