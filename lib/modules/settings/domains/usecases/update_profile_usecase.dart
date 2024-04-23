
import 'package:padi/modules/settings/domains/entities/update_profile_entity.dart';
import 'package:padi/modules/settings/infra/models/update_profile_model.dart';
import 'package:padi/modules/settings/infra/sources/update_profile_services.dart';

class UpdateProfileUseCase {
  final UpdateProfileServices _updateProfileServices;

  UpdateProfileUseCase(this._updateProfileServices);

  Future<UpdateProfile> updateProfile(UpdateProfileBodyRequest body) async {
    final updateProfileData = await _updateProfileServices.updateProfile(body);

    final updateProfile = UpdateProfile(
      status: updateProfileData.status,
      data: updateProfileData.data,
      message: updateProfileData.message,
    );

    return updateProfile;
  }
}