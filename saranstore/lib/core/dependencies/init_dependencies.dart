import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:saranstore/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:saranstore/feature/home/data/repository/home_repository_impl.dart';
import 'package:saranstore/feature/home/domain/repository/home_repository.dart';
import 'package:saranstore/feature/home/domain/usecase/add_product_usecase.dart';
import 'package:saranstore/feature/home/domain/usecase/get_products_usecase.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import '../network/dio_client.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  /// Dio
  serviceLocator.registerLazySingleton<Dio>(() => DioClient.dio);

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
    () => HomeBloc(getProductsUsecase: serviceLocator(),addProductUsecase: serviceLocator()),
  );

  /*---------------- Add Product ------------------------*/

  //usecase
  serviceLocator.registerLazySingleton(
    () => AddProductUsecase(repository: serviceLocator()),
  );
}
