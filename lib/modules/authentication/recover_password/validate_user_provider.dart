import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domains/entities/validate_user_entity.dart';
import 'domains/usecases/validate_user_usecase.dart';
import 'infra/models/validate_user_model.dart';
import 'infra/sources/validate_user_services.dart';

class ValidateUserFormState {
  final bool visible;
  final bool enabledEmailForm;

  ValidateUserFormState(this.visible, this.enabledEmailForm);
}

class ValidateUserFormNotifier extends StateNotifier<ValidateUserFormState> {
  ValidateUserFormNotifier() : super(ValidateUserFormState(true, true)) {
    hideValidateUserForm();
    showValidateUserForm();
  }

  void hideValidateUserForm() {
    state = ValidateUserFormState(false, false);
  }

  void showValidateUserForm() {
    state = ValidateUserFormState(true, true);
  }

}

final validateUserFormProvider = StateNotifierProvider.autoDispose<ValidateUserFormNotifier, ValidateUserFormState>((ref) {
  return ValidateUserFormNotifier();
});

final validateUserServicesProvider = Provider<ValidateUserServices>((ref) {
  return ValidateUserServices();
});

final validateUserUseCaseProvider = Provider<ValidateUserUseCase>((ref) {
  final validateUserServices = ref.watch(validateUserServicesProvider);
  return ValidateUserUseCase(validateUserServices);
});

final validateUserProvider = Provider<ValidateUserProvider>((ref) {
  final validateUserUseCase = ref.watch(validateUserUseCaseProvider);
  return ValidateUserProvider(validateUserUseCase);
});
class ValidateUserProvider {
  final ValidateUserUseCase validateUserUseCase;

  ValidateUserProvider(this.validateUserUseCase);

  Future<ValidateUser> validateUser(ValidateUserBodyRequest body) async {
    try {
      final response = await validateUserUseCase.validateUser(body);
      return response;
    } on Exception catch (e) {
      e.toString();
      rethrow;
    }
  }
}