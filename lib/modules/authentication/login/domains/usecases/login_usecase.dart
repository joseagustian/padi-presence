import 'package:padi/modules/authentication/login/domains/entities/login_entity.dart';
import 'package:padi/modules/authentication/login/infra/models/login_model.dart';
import 'package:padi/modules/authentication/login/infra/sources/login_services.dart';

class LoginUseCase {
  final LoginServices loginServices;
  LoginUseCase(this.loginServices);

  Future<Login> login(LoginBodyRequest body) async {
    final loginData = await loginServices.login(body);

    final login = Login(
      status: loginData.status,
      data: LoginData(
        id: loginData.data!.id,
        email: loginData.data!.email,
        password: loginData.data!.password,
        accessCode: loginData.data!.accessCode,
        reminder: loginData.data!.reminder,
        status: loginData.data!.status,
        name: loginData.data!.name,
        nip: loginData.data!.nip,
        dateOfBirth: loginData.data!.dateOfBirth,
        address: loginData.data!.address,
        religion: loginData.data!.religion,
        positionName: loginData.data!.positionName,
        divisionName: loginData.data!.divisionName,
        officeLat: loginData.data!.officeLat,
        officeLong: loginData.data!.officeLong,
        onProgressAttendanceId: loginData.data!.onProgressAttendanceId,
      ),
      token: loginData.token,
      message: loginData.message,
    );

    return login;
  }

}
