import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/feature/home/domain/usecase/add_product_usecase.dart';
import 'package:saranstore/feature/home/domain/usecase/get_categories_usecase.dart';

import '../../domain/usecase/get_products_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUsecase getProductsUsecase;
  final AddProductUsecase addProductUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  HomeBloc({
    required this.getProductsUsecase,
    required this.addProductUsecase,
    required this.getCategoriesUsecase,
  }) : super(HomeInitial()) {
    on<FetchProductsEvent>(_fetchProducts);
    on<AddProductEvent>(_addProduct);
    on<FetchCategoriesEvent>(_fetchCategories);
  }

  Future<void> _fetchProducts(
    FetchProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final currentState = state is HomeLoaded ? state as HomeLoaded : null;
      emit(HomeLoading());

      final products = await getProductsUsecase(event.categorySlug.slug);

      emit(
        HomeLoaded(
          products: products,
          isAdded: false,
          categories: currentState?.categories ?? [],
          selectedCategory: event.categorySlug,
        ),
      );
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
        emit(HomeLoading());
        final addedProduct = await addProductUsecase(event.product);

        final updatedProducts = [addedProduct, ...currentState.products];

        emit(
          HomeLoaded(
            products: updatedProducts,
            isAdded: true,
            categories: currentState.categories,
            selectedCategory: currentState.selectedCategory,
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }

  Future<void> _fetchCategories(
    FetchCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (event.isFromProductsList) {
        final currentState = state is HomeLoaded ? state as HomeLoaded : null;
        emit(
          HomeLoaded(
            products: [],
            isAdded: false,
            categories: currentState?.categories ?? [],
            selectedCategory: null,
          ),
        );
        return;
      } else {
        // final currentState = state is HomeLoaded ? state as HomeLoaded : null;

        emit(HomeLoading());

        final categories = await getCategoriesUsecase();

        emit(
          HomeLoaded(
            products: [],
            isAdded: false,
            categories: categories,
          ),
        );
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
