import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/feature/home/domain/usecase/add_product_usecase.dart';

import '../../domain/usecase/get_products_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUsecase getProductsUsecase;
  final AddProductUsecase addProductUsecase;
  HomeBloc({required this.getProductsUsecase, required this.addProductUsecase}) : super(HomeInitial()) {
    on<FetchProductsEvent>(_fetchProducts);
    on<AddProductEvent>(_addProduct);
  }

  Future<void> _fetchProducts(
    FetchProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());

      final products = await getProductsUsecase();

      emit(HomeLoaded(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _addProduct(
    AddProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      try {
        final addedProduct = await addProductUsecase(event.product);

        final updatedProducts = [addedProduct, ...currentState.products];

        emit(HomeLoaded(updatedProducts));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }
}
