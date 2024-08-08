import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/widgets/auth_datepicker_form.dart';
import 'package:padi/modules/authentication/widgets/auth_dropdown_form.dart';
import 'package:padi/modules/authentication/widgets/auth_textfield.dart';
import 'package:padi/modules/shared/presenters/date_picker/date_picker_dialog.dart';
import 'package:padi/modules/shared/presenters/employee_position/employee_position_provider.dart';
import 'package:padi/modules/shared/presenters/job_division/job_division_provider.dart';
import 'package:padi/modules/shared/presenters/location/office/all_office_location_provider.dart';
import 'package:padi/modules/shared/presenters/security_question/security_question_provider.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.securityQuestionController,
    required this.securityAnswerController,
    required this.birthDateController,
    required this.divisionController,
    required this.positionController,
    required this.officeLocationController,
    required this.passwordController,
    required this.confirmationPasswordController,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController securityQuestionController;
  final TextEditingController securityAnswerController;
  final TextEditingController birthDateController;
  final TextEditingController divisionController;
  final TextEditingController positionController;
  final TextEditingController officeLocationController;
  final TextEditingController passwordController;
  final TextEditingController confirmationPasswordController;
  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _securityQuestionDropdownKey = GlobalKey<FormFieldState>();
  final _jobDivisionDropdownKey = GlobalKey<FormFieldState>();
  final _employeePositionDropdownKey = GlobalKey<FormFieldState>();
  final _officeLocationDropdownKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Expanded(
          child: RawScrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            thumbColor: Colors.blueGrey[900],
            trackColor: Colors.blueGrey[300],
            thickness: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
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
                    AuthTextField(
                        hintText: Strings.inputFullName,
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        enabled: true,
                        controller: widget.fullNameController,
                        validator: Validator.validateFullName
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Strings.email,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthTextField(
                        hintText: Strings.inputEmail,
                        prefixIcon: Icons.mail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        enabled: true,
                        controller: widget.emailController,
                        validator: Validator.validateEmail
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Strings.securityQuestion,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthDropdownForm(
                        dropdownKey: _securityQuestionDropdownKey,
                        onTap: () {
                          return ref.refresh(securityQuestionProvider);
                        },
                        items: ref.watch(securityQuestionProvider).when(
                            data: (securityQuestions) {
                              return securityQuestions.data.map((securityQuestion) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    widget.securityQuestionController.text = securityQuestion.id.toString();
                                  },
                                  value: securityQuestion.id,
                                  child: Text(
                                    securityQuestion.question,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList();
                            },
                            loading: () => [],
                            error: (e, s) => []
                        ),
                        onChanged: (value) {},
                        value: null,
                        hint: Text(
                          ref.watch(securityQuestionProvider).isLoading ? Strings.loading
                              : ref.watch(securityQuestionProvider).error != null ? Strings.failToLoadSecurityQuestion
                              : Strings.selectSecurityQuestion,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          return Validator.validateSecurityQuestionSelection(value);
                        },
                        isLoading: ref.watch(securityQuestionProvider).isLoading,
                        isError: ref.watch(securityQuestionProvider).error != null,
                        prefixIcon: Icons.question_answer_outlined
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Strings.answerSecurityQuestion,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthTextField(
                        hintText: Strings.inputAnswerSecurityQuestion,
                        prefixIcon: Icons.question_answer,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        enabled: true,
                        controller: widget.securityAnswerController,
                        validator: Validator.validateSecurityQuestionAnswer
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
                    AuthDatePickerForm(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SfDatePickerDialog(
                              controller: widget.birthDateController,
                            ),
                          );
                        },
                        hintText: Strings.selectBirthDate,
                        prefixIcon: Icons.edit_calendar,
                        textInputAction: TextInputAction.next,
                        controller: widget.birthDateController,
                        validator: Validator.validateBirthDateSelection
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Strings.division,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthDropdownForm(
                        dropdownKey: _jobDivisionDropdownKey,
                        onTap: () {
                          return ref.refresh(jobDivisionProvider);
                        },
                        items: ref.watch(jobDivisionProvider).when(
                            data: (divisions) {
                              return divisions.data.map((division) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    ref.refresh(employeePositionProvider(widget.divisionController.text)).value;
                                    widget.divisionController.text = division.id.toString();
                                    ref.invalidate(employeePositionProvider(widget.divisionController.text));
                                    _employeePositionDropdownKey.currentState?.reset();
                                  },
                                  value: division.id,
                                  child: Text(division.divisionName),
                                );
                              }).toList();
                            },
                            loading: () => [],
                            error: (e, s) => []
                        ),
                        onChanged: (value) {},
                        value: null,
                        hint: Text(
                          ref.watch(jobDivisionProvider).isLoading ? Strings.loading
                              : ref.watch(jobDivisionProvider).error != null ? Strings.failToLoadJobDivision
                              : Strings.selectDivision,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          Validator.validateDivisionSelection(value);
                          return null;
                        },
                        isLoading: ref.watch(jobDivisionProvider).isLoading,
                        isError: ref.watch(jobDivisionProvider).error != null,
                        prefixIcon: Icons.groups
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Strings.position,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthDropdownForm(
                        dropdownKey: _employeePositionDropdownKey,
                        onTap: () {
                          return ref.refresh(employeePositionProvider(widget.divisionController.text));
                        },
                        items: ref.watch(employeePositionProvider(widget.divisionController.text)).when(
                            data: (positions) {
                              return positions.data.map((position) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    widget.positionController.text = position.id.toString();
                                  },
                                  value: position.id,
                                  child: Text(position.positionName),
                                );
                              }).toList();
                            },
                            loading: () => [],
                            error: (e, s) => []
                        ),
                        onChanged: (value) {

                        },
                        value: null,
                        hint: Text(
                          ref.watch(employeePositionProvider(widget.divisionController.text)).isLoading ? Strings.loading
                              : ref.watch(employeePositionProvider(widget.divisionController.text)).error != null ? Strings.failToLoadEmployeePosition
                              : Strings.selectPosition,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          Validator.validatePositionSelection(value);
                          return null;
                        },
                        isLoading: ref.watch(employeePositionProvider(widget.divisionController.text)).isLoading,
                        isError: ref.watch(employeePositionProvider(widget.divisionController.text)).error != null,
                        prefixIcon: Icons.person_search_rounded
                    ),
                    const SizedBox(height: 20),
                    //----------------- Office Location Dropdown -----------------//
                    Text(
                      Strings.officeLocation,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthDropdownForm(
                        dropdownKey: _officeLocationDropdownKey,
                        onTap: () {
                          return ref.refresh(allOfficeLocationProvider);
                        },
                        items: ref.watch(allOfficeLocationProvider).when(
                            data: (officeLocations) {
                              return officeLocations.data.map((location) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    widget.officeLocationController.text = location.id.toString();
                                  },
                                  value: location.id,
                                  child: Text(location.officeName),
                                );
                              }).toList();
                            },
                            loading: () => [],
                            error: (e, s) => []
                        ),
                        onChanged: (value) {

                        },
                        value: null,
                        hint: Text(
                          ref.watch(allOfficeLocationProvider).isLoading ? Strings.loading
                              : ref.watch(allOfficeLocationProvider).error != null ? Strings.failToLoadOfficeLocation
                              : Strings.selectOfficeLocation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          Validator.validatePositionSelection(value);
                          return null;
                        },
                        isLoading: ref.watch(allOfficeLocationProvider).isLoading,
                        isError: ref.watch(allOfficeLocationProvider).error != null,
                        prefixIcon: Icons.location_city_sharp
                    ),
                    //----------------- Office Location Dropdown -----------------//
                    const SizedBox(height: 20),
                    Text(
                      Strings.password,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthTextField(
                        hintText: Strings.inputPassword,
                        prefixIcon: Icons.key,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        enabled: true,
                        controller: widget.passwordController,
                        validator: Validator.validatePassword
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Strings.confirmationPassword,
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AuthTextField(
                        hintText: Strings.inputConfirmationPassword,
                        prefixIcon: Icons.key,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        enabled: true,
                        controller: widget.confirmationPasswordController,
                        validator: (value) {
                          Validator.validateConfirmationPassword(value, widget.passwordController.text);
                          return null;
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
