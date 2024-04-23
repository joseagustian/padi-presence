import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/login/presenters/validators/validate_login_form.dart';
import 'package:padi/modules/authentication/widgets/auth_textfield.dart';

import '../../login_provider.dart';
import 'login_button.dart';
import 'login_horizontal_button.dart';


class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final provider = ref.watch(loginProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              enabled: true,
              controller: emailController,
              validator: Validator.validateEmail
          ),
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
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              enabled: true,
              controller: passwordController,
              validator: Validator.validatePassword,
          ),
          const SizedBox(height: 15),
          LoginHorizontalButton(
              helperText: Strings.forgotPassword,
              buttonText: Strings.recover,
              onTap: () {
                router.push('/recover-password');
              },
          ),
          const SizedBox(height: 35),
          Align(
            alignment: Alignment.centerRight,
            child: LoginButton(
              isLoading: provider.isLoading,
              onPressed: () {
                validateLoginForm(
                    _formKey,
                    context,
                    emailController,
                    passwordController,
                    provider
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          LoginHorizontalButton(
              helperText: Strings.notHaveAccount,
              buttonText: Strings.register,
              onTap: () {
                router.push('/register');
              },
          ),
        ],
      ),
    );
  }
}
