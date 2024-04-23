import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/recover_password/presenters/validators/validate_recover_password_form_validator.dart';
import 'package:padi/modules/authentication/recover_password/presenters/validators/validate_user_form_validator.dart';
import 'package:padi/modules/authentication/recover_password/recover_password_provider.dart';
import 'package:padi/modules/authentication/recover_password/validate_user_provider.dart';
import 'package:padi/modules/authentication/widgets/auth_dropdown_form.dart';
import 'package:padi/modules/authentication/widgets/auth_textfield.dart';
import 'package:padi/modules/shared/presenters/security_question/security_question_provider.dart';

import 'recover_password_button.dart';
import 'validate_user_button.dart';

class RecoverPasswordForm extends ConsumerStatefulWidget {
  const RecoverPasswordForm({
    super.key
  });

  @override
  ConsumerState<RecoverPasswordForm> createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends ConsumerState<RecoverPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _securityQuestionDropdownKey = GlobalKey<FormFieldState>();
  final TextEditingController securityQuestionController = TextEditingController();
  final TextEditingController securityAnswerController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController = TextEditingController();
  final ExpandableController securityQuestionExpandableController = ExpandableController(
    initialExpanded: true,
  );
  final ExpandableController newPasswordExpandableController = ExpandableController(
    initialExpanded: false,
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(validateUserFormProvider);
    return Form(
      key: _formKey,
      child: Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      enabled: state.enabledEmailForm,
                      controller: emailController,
                      validator: Validator.validateEmail
                  ),
                  ExpandableNotifier(
                    controller: securityQuestionExpandableController,
                    child: Expandable(
                      collapsed: const SizedBox(),
                      expanded: Visibility(
                        visible: state.visible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                            securityQuestionController.text = securityQuestion.id.toString();
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
                                    fontWeight: FontWeight.bold,
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
                                controller: securityAnswerController,
                                validator: Validator.validateSecurityQuestionAnswer
                            ),
                            const SizedBox(height: 25),
                            ValidateUserButton(
                                onPressed: () {
                                  validateUserForm(
                                      context,
                                      emailController,
                                      securityQuestionController,
                                      securityAnswerController,
                                      securityQuestionExpandableController,
                                      newPasswordExpandableController,
                                    ref.watch(validateUserProvider),
                                      () {
                                        ref.read(validateUserFormProvider.notifier).hideValidateUserForm();
                                      }
                                  );
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ExpandableNotifier(
                      controller: newPasswordExpandableController,
                      child: Expandable(
                          collapsed: const SizedBox(),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.newPassword,
                                style: TextStyle(
                                  color: Colors.blueGrey[900],
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              AuthTextField(
                                  hintText: Strings.inputNewPassword,
                                  prefixIcon: Icons.key,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  enabled: true,
                                  controller: passwordController,
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
                                  controller: confirmationPasswordController,
                                  validator: (value) {
                                    Validator.validateConfirmationPassword(value, passwordController.text);
                                    return null;
                                  }
                              ),
                              const SizedBox(height: 25),
                              RecoverPasswordButton(
                                  onPressed: () {
                                    validateRecoverPasswordForm(
                                        context,
                                        emailController,
                                        passwordController,
                                        confirmationPasswordController,
                                        ref.watch(recoverPasswordProvider)
                                    );
                                  }
                              )
                            ],
                          )
                      )
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
