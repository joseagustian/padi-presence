import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/data/database/models/padi_user_model.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/core/data/database/repositories/padi_user_table_repository.dart';
import 'package:padi/modules/settings/presenters/validators/validate_update_profile.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/profile_settings_appbar.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/update_profile_button.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/update_profile_form.dart';
import 'package:padi/modules/settings/update_profile_provider.dart';

import 'update_profile_settings_state_provider.dart';

class ProfileSettingsPage extends ConsumerStatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  ConsumerState<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends ConsumerState<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateProfileSettingsStateProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSettingsAppBar(),
            UpdateProfileForm(
              updateNameController: state.updateNameController,
              updateBirthDateController: state.updateBirthDateController,
              updateEmployeeIDNumberController: state.updateEmployeeIDNumberController,
              updateEmployeeAddressController: state.updateEmployeeAddressController,
              updateEmployeeReligionController: state.updateEmployeeReligionController,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: UpdateProfileButton(
          onPressed: () {
            validateUpdateProfile(
                context,
                state.updateNameController,
                state.updateBirthDateController,
                state.updateEmployeeIDNumberController,
                state.updateEmployeeAddressController,
                state.updateEmployeeReligionController,
                ref.watch(updateProfileProvider),
                () async {
                  final data = await PadiUserAccountTableRepository().getPadiUserAccount();
                  PadiUserAccountTableRepository().updatePadiUserAccount(
                    PadiUserAccountModel(
                      userId: data!.userId,
                      userEmail: data.userEmail,
                      userAccountName: state.updateNameController.text,
                      userEmployeeId: state.updateEmployeeIDNumberController.text,
                      userDateOfBirth: state.updateBirthDateController.text,
                      userAddress: state.updateEmployeeAddressController.text,
                      userReligion: state.updateEmployeeReligionController.text,
                      userJobPosition: data.userJobPosition,
                      userJobDivision: data.userJobDivision,
                      userAccessToken: data.userAccessToken,
                      userOfficeLat: data.userOfficeLat,
                      userOfficeLong: data.userOfficeLong,
                      onProgressAttendanceId: data.onProgressAttendanceId,
                    ),
                  );
                  ref.refresh(employeeDataProvider);
                  ref.refresh(padiUserDataProvider);
                }
            );
          },
        ),
      ),
    );
  }
}
