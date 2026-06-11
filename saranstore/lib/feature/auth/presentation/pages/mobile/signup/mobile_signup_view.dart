import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_state.dart';
import 'package:saranstore/feature/auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:saranstore/feature/auth/presentation/pages/mobile/signup/signup_bottom_section.dart';
import 'package:saranstore/feature/auth/presentation/pages/mobile/signup/signup_middle_section.dart';
import 'package:saranstore/feature/auth/presentation/pages/mobile/signup/signup_top_section.dart';

class MobileSignupView extends StatefulWidget {
  const MobileSignupView({super.key});

  @override
  State<MobileSignupView> createState() => _MobileSignupViewState();
}

class _MobileSignupViewState extends State<MobileSignupView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordCubit = PasswordVisibilityCubit();
  final confirmPasswordCubit = PasswordVisibilityCubit();

  @override
  void initState() {
    super.initState();

    passwordCubit.reset();
    passwordCubit.reset();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordCubit.close();
    confirmPasswordCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPalette.primaryColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppPalette.white),
                    ),

                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          FocusScope.of(context).unfocus();
                          context.go(RouteNames.login);
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SignupTopSection(),

                                SizedBox(height: 5),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SignupMiddleSection(
                                      emailController: emailController,
                                      passwordController: passwordController,
                                      confirmPasswordController:
                                          confirmPasswordController,
                                      passwordCubit: passwordCubit,
                                      confirmPasswordCubit:
                                          confirmPasswordCubit,
                                    ),

                                    SizedBox(height: 15),

                                    SignupBottomSection(
                                      formKey: formKey,
                                      emailController: emailController,
                                      passwordController: passwordController,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
