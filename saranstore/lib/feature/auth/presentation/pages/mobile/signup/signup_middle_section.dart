import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/auth/presentation/cubit/password_visibility_cubit.dart';

class SignupMiddleSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final PasswordVisibilityCubit passwordCubit;
  final PasswordVisibilityCubit confirmPasswordCubit;
  const SignupMiddleSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordCubit,
    required this.confirmPasswordCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 16, color: AppPalette.white),
            ),
          ],
        ),
        SizedBox(height: 20),

        SsTextformfield(
          controller: emailController,
          labelText: 'Email',
          validator: validateEmail,
        ),

        SizedBox(height: 15),
        BlocBuilder<PasswordVisibilityCubit, bool>(
          bloc: passwordCubit,
          builder: (context, state) {
            return SsTextformfield(
              controller: passwordController,
              labelText: 'Password',
              validator: validatePassword,
              obscureText: state,
              suffix: GestureDetector(
                onTap: () {
                  passwordCubit.toggle();
                },
                child: state
                    ? Icon(Icons.visibility, color: AppPalette.white)
                    : Icon(Icons.visibility_off, color: AppPalette.white),
              ),
            );
          },
        ),

        SizedBox(height: 15),

        BlocBuilder<PasswordVisibilityCubit, bool>(
          bloc: confirmPasswordCubit,
          builder: (context, state) {
            return SsTextformfield(
              validator: (value) => validateConfirmPassword(
                password: passwordController.text,
                confirmPassword: value,
              ),
              controller: confirmPasswordController,
              labelText: 'Confirm Password',
              obscureText: state,
              suffix: GestureDetector(
                onTap: () {
                  confirmPasswordCubit.toggle();
                },
                child: state
                    ? Icon(Icons.visibility, color: AppPalette.white)
                    : Icon(Icons.visibility_off, color: AppPalette.white),
              ),
            );
          },
        ),
      ],
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!value.contains("@") || !value.contains(".com")) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'must be atleast 6 characters';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'must contain a special character';
    }
    return null;
  }

  String? validateConfirmPassword({String? password, String? confirmPassword}) {
    if (confirmPassword == null ||
        confirmPassword.isEmpty ||
        confirmPassword.trim().isEmpty) {
      return 'Confirm password is required';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
