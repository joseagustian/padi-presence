import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/update_profile_date_picker_form.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/update_profile_dropdown_form.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/update_profile_textfield.dart';
import 'package:padi/modules/shared/presenters/date_picker/date_picker_dialog.dart';

class UpdateProfileForm extends StatefulWidget {
  final TextEditingController updateNameController;
  final TextEditingController updateBirthDateController;
  final TextEditingController updateEmployeeIDNumberController;
  final TextEditingController updateEmployeeAddressController;
  final TextEditingController? updateEmployeeReligionController;
  const UpdateProfileForm({
    super.key,
    required this.updateNameController,
    required this.updateBirthDateController,
    required this.updateEmployeeIDNumberController,
    required this.updateEmployeeAddressController,
    required this.updateEmployeeReligionController,
  });

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final GlobalKey<FormFieldState> updateEmployeeReligionDropdownKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.fullName,
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              UpdateProfileTextField(
                  prefixIcon: Icons.person,
                  updateProfileController:
                  widget.updateNameController,
                  hintText: Strings.inputFullName,
              ),
              const SizedBox(height: 20),
              Text(
                Strings.birthDate,
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              UpdateProfileDatePickerForm(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SfDatePickerDialog(
                        controller: widget.updateBirthDateController,
                        isDisabledDateBefore: false,
                        isDisabledDateAfter: true,
                      ),
                    );
                  },
                  hintText: Strings.selectBirthDate,
                  prefixIcon: Icons.edit_calendar,
                  textInputAction: TextInputAction.next,
                  controller: widget.updateBirthDateController,
              ),
              const SizedBox(height: 20),
              Text(
                Strings.employeeIDNumber,
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              UpdateProfileTextField(
                prefixIcon: Icons.contacts,
                updateProfileController:
                widget.updateEmployeeIDNumberController,
                hintText: Strings.inputEmployeeIDNumber,
              ),
              const SizedBox(height: 20),
              Text(
                Strings.employeeAddress,
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              UpdateProfileTextField(
                prefixIcon: Icons.location_city,
                updateProfileController:
                widget.updateEmployeeAddressController,
                hintText: Strings.inputEmployeeAddress,
              ),
              const SizedBox(height: 20),
              Text(
                Strings.employeeReligion,
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              UpdateProfileDropdownForm(
                  dropdownKey: updateEmployeeReligionDropdownKey,
                  onTap: () {

                  },
                  items: const [
                    DropdownMenuItem(
                      value: Strings.religionMuslim,
                      child: Text(
                        Strings.religionMuslim,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Strings.religionChristian,
                      child: Text(
                        Strings.religionChristian,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Strings.religionCatholic,
                      child: Text(
                        Strings.religionCatholic,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Strings.religionHindu,
                      child: Text(
                        Strings.religionHindu,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Strings.religionBuddha,
                      child: Text(
                        Strings.religionBuddha,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Strings.religionConfucian,
                      child: Text(
                        Strings.religionConfucian,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.updateEmployeeReligionController?.text = value;
                    });
                  },
                  value: widget.updateEmployeeReligionController?.text == '' ? null : widget.updateEmployeeReligionController?.text,
                  hint: const Text(
                    Strings.inputEmployeeReligion,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 14,
                    ),
                  ),
                  isLoading: false,
                  isError: false,
                  prefixIcon: Icons.diversity_3,
              )
            ]
          ),
        )
      )
    );
  }
}
