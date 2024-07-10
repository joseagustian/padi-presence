import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presenters/validators/validate_register_form.dart';
import 'presenters/widgets/register_appbar.dart';
import 'presenters/widgets/register_button.dart';
import 'presenters/widgets/register_form.dart';
import 'register_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final securityQuestionController = TextEditingController();
  final securityAnswerController = TextEditingController();
  final birthDateController = TextEditingController();
  final divisionController = TextEditingController();
  final positionController = TextEditingController();
  final officeLocationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RegisterAppBar(),
                  RegisterForm(
                    fullNameController: nameController,
                    emailController: emailController,
                    securityQuestionController: securityQuestionController,
                    securityAnswerController: securityAnswerController,
                    birthDateController: birthDateController,
                    divisionController: divisionController,
                    positionController: positionController,
                    officeLocationController: officeLocationController,
                    passwordController: passwordController,
                    confirmationPasswordController: confirmationPasswordController,
                  ),
                ],
              ),
            )
        ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(right: 15),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Align(
          alignment: Alignment.topRight,
          child: RegisterButton(
            isLoading: false,
            onPressed: () {
              validateRegisterForm(
                context,
                nameController,
                emailController,
                securityQuestionController,
                securityAnswerController,
                birthDateController,
                officeLocationController,
                divisionController,
                positionController,
                passwordController,
                confirmationPasswordController,
                ref.watch(registerProvider),
              );
            },
          ),
        ),
      ),
    );
  }
}
