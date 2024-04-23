
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/settings/domains/entities/update_profile_entity.dart';
import 'package:padi/modules/settings/infra/models/update_profile_model.dart';

import 'domains/usecases/update_profile_usecase.dart';
import 'infra/sources/update_profile_services.dart';

final updateProfileServicesProvider = Provider<UpdateProfileServices>((ref) {
  return UpdateProfileServices();
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final updateProfileServices = ref.watch(updateProfileServicesProvider);
  return UpdateProfileUseCase(updateProfileServices);
});

final updateProfileProvider = Provider<UpdateProfileProvider>((ref) {
  final updateProfileUseCase = ref.watch(updateProfileUseCaseProvider);
  return UpdateProfileProvider(updateProfileUseCase);
});

class UpdateProfileProvider {
  final UpdateProfileUseCase updateProfileUseCase;

  UpdateProfileProvider(this.updateProfileUseCase);

  bool isLoading = false;
  String? error;

  Future<UpdateProfile> updateProfile(UpdateProfileBodyRequest body) async {
    isLoading = true;

    try {
      final response = await updateProfileUseCase.updateProfile(body);
      isLoading = false;
      return response;
    } on Exception catch (e) {
      error = e.toString();
      rethrow;
    }
  }

}