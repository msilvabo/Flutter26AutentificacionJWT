
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslo_shop/features/auth/domain/entities/screen_form_state.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

part 'screen_form_provider.g.dart';

@riverpod
class ScreenFormNotifier extends _$ScreenFormNotifier {
  @override
  ScreenFormState build() => ScreenFormState();

  onFullNameChange(String value) {
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
        fullName: newFullName,
        isValid: Formz.validate([newFullName, state.email, state.password]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.fullName, state.password]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email, state.fullName]));
  }

  onFormSubmit() {
    _touchEveryField();
    ref.watch(authProvider.notifier).registerUser(
        state.email.value, state.password.value);
    if (!state.isValid) return;
    print(state);
  }

  _touchEveryField() {
    final fullName = FullName.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        fullName: fullName,
        email: email,
        password: password,
        isValid: Formz.validate([fullName, email, password]));
  }
}
