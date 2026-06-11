import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:saranstore/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:saranstore/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:saranstore/feature/auth/domain/repository/auth_repository.dart';
import 'package:saranstore/feature/auth/domain/usecase/login_usecase.dart';
import 'package:saranstore/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:saranstore/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:saranstore/feature/auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:saranstore/feature/home/data/repository/home_repository_impl.dart';
import 'package:saranstore/feature/home/domain/repository/home_repository.dart';
import 'package:saranstore/feature/home/domain/usecase/add_product_usecase.dart';
import 'package:saranstore/feature/home/domain/usecase/get_categories_usecase.dart';
import 'package:saranstore/feature/home/domain/usecase/get_products_usecase.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/cubit/image_slider_cubit.dart';
import '../network/dio_client.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  /// Dio
  serviceLocator.registerLazySingleton<Dio>(() => DioClient.dio);

  /// FirebaseAuth
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  /*---------------- Authentication ------------------------*/
  /// Datasource
  serviceLocator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(firebaseAuth: serviceLocator()),
  );

  /// Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: serviceLocator()),
  );

  /// UseCase
  serviceLocator.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(repository: serviceLocator()),
  );

  /// UseCase
  serviceLocator.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(repository: serviceLocator()),
  );

  /// UseCase
  serviceLocator.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(repository: serviceLocator()),
  );

  /// Bloc
  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      signupUsecase: serviceLocator(),
      loginUsecase: serviceLocator(),
      logoutUsecase: serviceLocator(),
    ),
  );

  /*---------------- Get Products ------------------------*/
  /// Datasource
  serviceLocator.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasource(dio: serviceLocator()),
  );

  /// Repository
  serviceLocator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDatasource: serviceLocator()),
  );

  /// UseCase
  serviceLocator.registerLazySingleton<GetProductsUsecase>(
    () => GetProductsUsecase(repository: serviceLocator()),
  );

  /// Bloc
  serviceLocator.registerFactory<HomeBloc>(
    () => HomeBloc(
      getProductsUsecase: serviceLocator(),
      addProductUsecase: serviceLocator(),
      getCategoriesUsecase: serviceLocator(),
    ),
  );

  /*---------------- Add Product ------------------------*/

  /// UseCase
  serviceLocator.registerLazySingleton<AddProductUsecase>(
    () => AddProductUsecase(repository: serviceLocator()),
  );

  /*---------------- Add Product ------------------------*/

  /// UseCase
  serviceLocator.registerLazySingleton<GetCategoriesUsecase>(
    () => GetCategoriesUsecase(repository: serviceLocator()),
  );

  /*---------------- CART ------------------------*/

  /// Bloc
  serviceLocator.registerFactory<CartBloc>(() => CartBloc());

  /*---------------- Image Slider ------------------------*/

  /// Cubit
  serviceLocator.registerFactory<ImageSliderCubit>(() => ImageSliderCubit());

  /*---------------- Password visibility ------------------------*/

  /// Cubit
  serviceLocator.registerFactory<PasswordVisibilityCubit>(() => PasswordVisibilityCubit());
}
