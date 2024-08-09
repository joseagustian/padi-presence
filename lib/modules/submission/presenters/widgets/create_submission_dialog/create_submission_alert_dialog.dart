import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/constant.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/presenters/date_picker/date_picker_dialog.dart';
import 'package:padi/modules/submission/create_submission_provider.dart';
import 'package:padi/modules/submission/presenters/validators/validate_create_submission_form.dart';
import 'package:padi/modules/submission/presenters/widgets/create_submission_dialog/create_submission_dialog_button.dart';
import 'package:padi/modules/submission/presenters/widgets/create_submission_dialog/create_submission_dropdown_form.dart';
import 'package:padi/modules/submission/presenters/widgets/create_submission_dialog/create_submission_textfield.dart';

import 'create_submission_datepicker_form.dart';

class CreateSubmissionAlertDialog extends ConsumerStatefulWidget {
  const CreateSubmissionAlertDialog({super.key});

  @override
  ConsumerState<CreateSubmissionAlertDialog> createState() => _CreateSubmissionAlertDialogState();
}

class _CreateSubmissionAlertDialogState extends ConsumerState<CreateSubmissionAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _submissionTypeDropdownKey = GlobalKey<FormFieldState>();
  final _submissionTypeController = TextEditingController();
  final _submissionStartDateController = TextEditingController();
  final _submissionEndDateController = TextEditingController();
  final _submissionDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.blueGrey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        ),
      ),
      insetPadding: const EdgeInsets.all(15.0),
      contentPadding: const EdgeInsets.all(20.0),
      clipBehavior: Clip.antiAlias,
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 1,
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.createSubmission,
                  style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  Strings.submissionType,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                CreateSubmissionDropdownForm(
                    dropdownKey: _submissionTypeDropdownKey,
                    items: SUBMISSION_TYPE_MAP.entries.map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                        onTap: () {
                          _submissionTypeController.text = e.key;
                        },
                    )).toList(),
                    onChanged: (value) {},
                    value: null,
                    hint: const Text(
                      Strings.selectSubmissionType,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                    prefixIcon: Bootstrap.list_task
                ),
                const SizedBox(height: 10.0),
                Text(
                  Strings.submissionStartDate,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                CreateSubmissionDatePickerForm(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SfDatePickerDialog(
                        controller: _submissionStartDateController,
                        isDisabledDateBefore: false,
                        isDisabledDateAfter: false,
                      ),
                    );
                  },
                  hintText: Strings.selectSubmissionStartDate,
                  prefixIcon: Bootstrap.calendar2_week,
                  textInputAction: TextInputAction.next,
                  controller: _submissionStartDateController,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                Text(
                  Strings.submissionEndDate,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                CreateSubmissionDatePickerForm(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SfDatePickerDialog(
                        controller: _submissionEndDateController,
                        isDisabledDateBefore: false,
                        isDisabledDateAfter: false,
                      ),
                    );
                  },
                  hintText: Strings.selectSubmissionEndDate,
                  prefixIcon: Bootstrap.calendar2_week_fill,
                  textInputAction: TextInputAction.next,
                  controller: _submissionEndDateController,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                Text(
                  Strings.submissionDescription,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                CreateSubmissionTextField(
                    controller: _submissionDescriptionController,
                    hintText: Strings.inputSubmissionDescription,
                    prefixIcon: Bootstrap.journal_text
                ),
                const SizedBox(height: 20.0),
                CreateSubmissionDialogButton(
                    onPressed: () {
                      validateCreateSubmissionForm(
                          context, 
                          _submissionTypeController, 
                          _submissionStartDateController, 
                          _submissionEndDateController,
                          _submissionDescriptionController, 
                          ref.watch(createSubmissionProvider)
                      );
                    },
                    title: Strings.sendSubmission
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCreateSubmissionAlertDialog(
    BuildContext context,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CreateSubmissionAlertDialog();
    },
  );
}