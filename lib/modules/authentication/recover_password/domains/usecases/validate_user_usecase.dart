import 'package:padi/modules/authentication/recover_password/domains/entities/validate_user_entity.dart';
import 'package:padi/modules/authentication/recover_password/infra/models/validate_user_model.dart';
import 'package:padi/modules/authentication/recover_password/infra/sources/validate_user_services.dart';

class ValidateUserUseCase {
  final ValidateUserServices validateUserServices;

  ValidateUserUseCase(this.validateUserServices);

  Future<ValidateUser> validateUser(ValidateUserBodyRequest body) async {
    final validateUserResponse = await validateUserServices.validateUser(body);

    final validateUser = ValidateUser(
      status: validateUserResponse.status,
      data: validateUserResponse.data,
      message: validateUserResponse.message
    );

    return validateUser;
  }
}