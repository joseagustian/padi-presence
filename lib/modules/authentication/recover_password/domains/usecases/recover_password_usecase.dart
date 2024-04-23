import 'package:padi/modules/authentication/recover_password/domains/entities/recover_password_entity.dart';
import 'package:padi/modules/authentication/recover_password/infra/models/recover_password_model.dart';
import 'package:padi/modules/authentication/recover_password/infra/sources/recover_password_services.dart';

class RecoverPasswordUseCase {
  final RecoverPasswordServices recoverPasswordServices;

  RecoverPasswordUseCase(this.recoverPasswordServices);

  Future<RecoverPassword> recoverPassword(RecoverPasswordBodyRequest body) async {
    final recoverPasswordResponse = await recoverPasswordServices.recoverPassword(body);

    final recoverPassword = RecoverPassword(
        status: recoverPasswordResponse.status,
        message: recoverPasswordResponse.message
    );

    return recoverPassword;
  }
}