import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/dependencies/init_dependencies.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const SaranStoreApp());
}

class SaranStoreApp extends StatelessWidget {
  const SaranStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => serviceLocator<HomeBloc>()..add(FetchProductsEvent()),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          scrollbars: false,
        ),
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
        home: const HomePage(),
      ),
    );
  }
}
