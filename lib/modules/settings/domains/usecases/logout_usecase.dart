
import 'package:padi/modules/settings/domains/entities/logout_entity.dart';
import 'package:padi/modules/settings/infra/sources/logout_services.dart';

class LogoutUseCase {
  final LogoutServices _logoutServices;

  LogoutUseCase(this._logoutServices);

  Future<Logout> logout() async {
    final logoutData = await _logoutServices.logout();

    final logout = Logout(
      status: logoutData.status,
      data: logoutData.data,
      message: logoutData.message,
    );

    return logout;
  }

}