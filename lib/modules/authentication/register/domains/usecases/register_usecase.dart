import 'package:padi/modules/authentication/register/domains/entities/register_entity.dart';
import 'package:padi/modules/authentication/register/infra/models/register_model.dart';
import 'package:padi/modules/authentication/register/infra/sources/register_services.dart';

class RegisterUseCase {
  final RegisterServices registerServices;

  RegisterUseCase(this.registerServices);

  Future<Register> register(RegisterBodyRequest body) async {
    final registerResponse = await registerServices.register(body);

    final register = Register(
      status: registerResponse.status,
      data: registerResponse.data,
      message: registerResponse.message
    );

    return register;
  }
}