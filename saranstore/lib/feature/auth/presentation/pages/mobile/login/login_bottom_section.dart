import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_event.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_state.dart';

class LoginBottomSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginBottomSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: SizedBox()),
            Expanded(
              flex: 4,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return SsButton(
                    isLoading: state is AuthLoading ? true : false,
                    onPressed: state is AuthLoading
                        ? () {}
                        : () {
                            if (!(formKey.currentState!.validate())) {
                              return;
                            }
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          },
                    buttonText: 'Login',
                  );
                },
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),

        SizedBox(height: 4),

        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthError) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      state.message,
                      style: TextStyle(fontSize: 14, color: AppPalette.red),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),

        SizedBox(height: 25),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(fontSize: 16, color: AppPalette.white),
            ),
            GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(ClearAuthError());
                context.go(RouteNames.signup);
              },
              child: Text(
                "Signup",
                style: TextStyle(
                  fontSize: 16,
                  color: AppPalette.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
