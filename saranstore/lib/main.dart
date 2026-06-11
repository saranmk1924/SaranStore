import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/dependencies/init_dependencies.dart';
import 'package:saranstore/core/router/app_router.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:saranstore/feature/auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/cubit/image_slider_cubit.dart';
import 'package:saranstore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initDependencies();

  runApp(const SaranStoreApp());
}

class SaranStoreApp extends StatelessWidget {
  const SaranStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => serviceLocator<HomeBloc>()),
        BlocProvider<CartBloc>(create: (_) => serviceLocator<CartBloc>()),
        BlocProvider<ImageSliderCubit>(create: (_) => serviceLocator<ImageSliderCubit>(),),
        BlocProvider<AuthBloc>(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider<PasswordVisibilityCubit>(
          create: (_) => serviceLocator<PasswordVisibilityCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        scrollBehavior: MyScrollbarBehavior().copyWith(scrollbars: false),
        debugShowCheckedModeBanner: false,
        title: 'SaranStore',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppPalette.primaryColor,
          
          appBarTheme: const AppBarTheme(
            backgroundColor: AppPalette.primaryColor,
            elevation: 0,
            surfaceTintColor: AppPalette.primaryColor,
          ),
        ),
      ),
    );
  }
}

class MyScrollbarBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
