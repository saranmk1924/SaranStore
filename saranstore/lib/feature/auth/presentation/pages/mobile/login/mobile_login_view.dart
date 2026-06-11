import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_state.dart';
import 'package:saranstore/feature/auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:saranstore/feature/auth/presentation/pages/mobile/login/login_bottom_section.dart';
import 'package:saranstore/feature/auth/presentation/pages/mobile/login/login_middle_section.dart';
import 'package:saranstore/feature/auth/presentation/pages/mobile/login/login_top_section.dart';

class MobileLoginView extends StatefulWidget {
  const MobileLoginView({super.key});

  @override
  State<MobileLoginView> createState() => _MobileLoginViewState();
}

class _MobileLoginViewState extends State<MobileLoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordCubit = PasswordVisibilityCubit();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordCubit.reset();
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
                          context.go(RouteNames.home);
                        }
                        if (state is AuthError) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoginTopSection(),

                                  SizedBox(height: 5),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LoginMiddleSection(
                                        emailController: emailController,
                                        passwordController: passwordController,
                                        passwordCubit: passwordCubit,
                                      ),

                                      SizedBox(height: 15),

                                      LoginBottomSection(
                                        formKey: formKey,
                                        emailController: emailController,
                                        passwordController: passwordController,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
