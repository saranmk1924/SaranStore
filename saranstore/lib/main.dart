import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/dependencies/init_dependencies.dart';
import 'package:saranstore/core/router/app_router.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/cubit/image_slider_cubit.dart';
import 'package:saranstore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initDependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        BlocProvider<ImageSliderCubit>(
          create: (_) => serviceLocator<ImageSliderCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        scrollBehavior: MyScrollbarBehavior().copyWith(scrollbars: false),
        debugShowCheckedModeBanner: false,
        title: 'SaranStore',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xffF5F5F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
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
