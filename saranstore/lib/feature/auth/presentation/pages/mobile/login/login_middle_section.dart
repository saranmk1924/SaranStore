import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/auth/presentation/cubit/password_visibility_cubit.dart';

class LoginMiddleSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final PasswordVisibilityCubit passwordCubit;
  const LoginMiddleSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back 👋',
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
}
