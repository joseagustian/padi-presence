
import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/settings/infra/models/update_profile_model.dart';
import 'package:padi/modules/settings/update_profile_provider.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

void validateUpdateProfile(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController birthDateController,
    TextEditingController employeeIDNumberController,
    TextEditingController employeeAddressController,
    TextEditingController employeeReligionController,
    UpdateProfileProvider updateProfileProvider,
    Function() updateUserDataOnSuccess,
    ) {
  final fullName = nameController.text;
  final dateOfBirth = birthDateController.text;
  final employeeIDNumber = employeeIDNumberController.text;
  final employeeAddress = employeeAddressController.text;
  final employeeReligion = employeeReligionController.text;
  final allEmpty = fullName.isEmpty && dateOfBirth.isEmpty && employeeIDNumber.isEmpty && employeeAddress.isEmpty && employeeReligion.isEmpty;

  final validationErrors = {
    'Full Name': Validator.validateFullName(fullName),
    'Date of Birth': Validator.validateBirthDateSelection(dateOfBirth),
    'Employee ID': Validator.validateEmployeeIDNumber(employeeIDNumber),
    'Address': Validator.validateEmployeeAddress(employeeAddress),
    'Religion': Validator.validateEmployeeReligion(employeeReligion),
  };

  if (allEmpty) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        Strings.makeSureAllFieldsFilled,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
    return;
  }

  validationErrors.forEach((key, value) {
    if (value != null) {
      bool error = false;
      showMessengerAlertDialog(
          context,
          value,
          error,
              () {
            Navigator.of(context, rootNavigator: true).pop();
          }
      );
      return;
    }
  });

  UpdateProfileBodyRequest updateProfileBodyRequest = UpdateProfileBodyRequest(
    fullName: fullName,
    dateOfBirth: dateOfBirth,
    employeeId: employeeIDNumber,
    address: employeeAddress,
    religion: employeeReligion,
  );

  showLoadingAlertDialog(
      context,
    Strings.updatingProfile,
  );

  updateProfileProvider.updateProfile(updateProfileBodyRequest).then((value) {
    Navigator.of(context, rootNavigator: true).pop();
    bool success = true;
    showMessengerAlertDialog(
        context,
        Strings.updateProfileSuccess,
        success,
            () {
              Navigator.of(context, rootNavigator: true).pop();
        }
    );
    updateUserDataOnSuccess();
  }).catchError(
          (e) {
        Navigator.of(context, rootNavigator: true).pop();
        bool error = false;
        showMessengerAlertDialog(context,
            e.toString().contains('ClientException') ? Strings.noInternetConnection :  e.toString().replaceAll('Exception:', ''),
            error,
                () {
              Navigator.of(context, rootNavigator: true).pop();
            }
        );
      }
  );
}