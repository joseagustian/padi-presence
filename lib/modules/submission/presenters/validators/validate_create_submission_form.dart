import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/submission/create_submission_provider.dart';
import 'package:padi/modules/submission/infra/models/create_submission_model.dart';

import '../../../shared/presenters/captcha_dialog/validators/validate_captcha_form.dart';

void validateCreateSubmissionForm(
    BuildContext context,
    TextEditingController submissionTypeController,
    TextEditingController submissionStartDateController,
    TextEditingController submissionEndDateController,
    TextEditingController submissionDescriptionController,
    CreateSubmissionProvider createSubmissionProvider
    ) {

    final submissionType = submissionTypeController.text;
    final submissionStartDate = submissionStartDateController.text;
    final submissionEndDate = submissionEndDateController.text;
    final submissionDescription = submissionDescriptionController.text;
    final allEmpty = submissionType.isEmpty && submissionStartDate.isEmpty && submissionEndDate.isEmpty && submissionDescription.isEmpty;

    final DateFormat inputDateFormat = DateFormat('dd-MM-yyyy');
    final DateFormat outputDateFormat = DateFormat('yyyy-MM-dd');

    final startDate = outputDateFormat.format(inputDateFormat.parse(submissionStartDate));
    final endDate = outputDateFormat.format(inputDateFormat.parse(submissionEndDate));

    final validationErrors = {
        'Submission Type': Validator.validateSubmissionType(submissionType),
        'Submission Start Date': Validator.validateSubmissionStartDate(submissionStartDate, submissionEndDate),
        'Submission End Date': Validator.validateSubmissionEndDate(submissionStartDate, submissionEndDate),
        'Submission Description': Validator.validateSubmissionDescription(submissionDescription),
    };

    final onSuccessAlertMessage = {
        'Pengajuan OUTOFTOWN berhasil.': Strings.submissionOutOfTownSuccess,
        'Pengajuan PERMIT berhasil.': Strings.submissionPermitSuccess,
        'Pengajuan SICK berhasil.': Strings.submissionSickSuccess,
        'Pengajuan LEAVE berhasil.': Strings.submissionLeaveSuccess,
    };

    final onErrorMessage = {
        'Durasi pengajuan tidak boleh lebih dari 12 hari.': Strings.submissionMoreThan12Days,
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

    for (var field in validationErrors.entries) {
        if (field.value != null) {
            bool error = false;
            showMessengerAlertDialog(
                context,
                field.value!,
                error,
                    () {
                    Navigator.of(context, rootNavigator: true).pop();
                }
            );
            return;
        }
    }

    CreateSubmissionBodyRequest createSubmissionBodyRequest = CreateSubmissionBodyRequest(
        submissionType: submissionType,
        startDate: startDate,
        endDate: endDate,
        description: submissionDescription,
    );

    showLoadingAlertDialog(
        context,
        Strings.sendingSubmission
    );

    createSubmissionProvider.createSubmission(createSubmissionBodyRequest).then((value) {
        Navigator.of(context, rootNavigator: true).pop();
        bool isSuccess = value.message.contains("berhasil");
        String responsesMessage = value.message;

        showMessengerAlertDialog(
            context,
            isSuccess ? onSuccessAlertMessage[responsesMessage]! : onErrorMessage[responsesMessage]!,
            isSuccess,
                () {
                Navigator.of(context, rootNavigator: true).pop();
            }
        );
    }).catchError((e) {
        Navigator.of(context, rootNavigator: true).pop();
        showMessengerAlertDialog(
            context,
            e.toString().replaceAll("Exception: ", ""),
            false,
                () {
                Navigator.of(context, rootNavigator: true).pop();
            }
        );
    });

}