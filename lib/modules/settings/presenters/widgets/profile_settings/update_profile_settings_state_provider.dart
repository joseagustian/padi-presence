
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';

class UpdateProfileSettingsState {
  TextEditingController updateNameController;
  TextEditingController updateBirthDateController;
  TextEditingController updateEmployeeIDNumberController;
  TextEditingController updateEmployeeAddressController;
  TextEditingController updateEmployeeReligionController;

  UpdateProfileSettingsState({
    required this.updateNameController,
    required this.updateBirthDateController,
    required this.updateEmployeeIDNumberController,
    required this.updateEmployeeAddressController,
    required this.updateEmployeeReligionController,
  });

  UpdateProfileSettingsState copyWith({
    TextEditingController? updateNameController,
    TextEditingController? updateBirthDateController,
    TextEditingController? updateEmployeeIDNumberController,
    TextEditingController? updateEmployeeAddressController,
    TextEditingController? updateEmployeeReligionController,
  }) {
    return UpdateProfileSettingsState(
      updateNameController: updateNameController ?? this.updateNameController,
      updateBirthDateController: updateBirthDateController ?? this.updateBirthDateController,
      updateEmployeeIDNumberController: updateEmployeeIDNumberController ?? this.updateEmployeeIDNumberController,
      updateEmployeeAddressController: updateEmployeeAddressController ?? this.updateEmployeeAddressController,
      updateEmployeeReligionController: updateEmployeeReligionController ?? this.updateEmployeeReligionController,
    );
  }

}

class UpdateProfileSettingsStateNotifier extends StateNotifier<UpdateProfileSettingsState> {

  final PadiUserTableDataProvider _padiUserTableProvider = PadiUserTableDataProvider();

  UpdateProfileSettingsStateNotifier() : super(UpdateProfileSettingsState(
    updateNameController: TextEditingController(),
    updateBirthDateController: TextEditingController(),
    updateEmployeeIDNumberController: TextEditingController(),
    updateEmployeeAddressController: TextEditingController(),
    updateEmployeeReligionController: TextEditingController(),
  )) {
    init();
  }

  void init() async {
    final data = await _padiUserTableProvider.getEmployeeData();

    final name = data['name'];
    final birthDate = data['dateOfBirth'];
    final employeeID = data['employeeId'];
    final employeeAddress = data['address'];
    final employeeReligion = data['religion'];

    state = state.copyWith(
      updateNameController: TextEditingController(text: name),
      updateBirthDateController: TextEditingController(text: birthDate),
      updateEmployeeIDNumberController: TextEditingController(text: employeeID),
      updateEmployeeAddressController: TextEditingController(text: employeeAddress),
      updateEmployeeReligionController: TextEditingController(text: employeeReligion),
    );

  }

}

final updateProfileSettingsStateProvider = StateNotifierProvider.autoDispose<UpdateProfileSettingsStateNotifier, UpdateProfileSettingsState>((ref) {
  return UpdateProfileSettingsStateNotifier();
});