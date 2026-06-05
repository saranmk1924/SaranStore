import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/enums/product_sort_type_enum.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
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
    on<SearchCategoryEvent>(_searchCategory);
    on<SearchProductEvent>(_searchProduct);
    on<SortProductsEvent>(_sortProducts);
    on<DeleteProductEvent>(_deleteProduct);
  }

  Future<void> _fetchProducts(
    FetchProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final currentState = state is HomeLoaded ? state as HomeLoaded : null;
      emit(HomeLoading());

      final products = await getProductsUsecase(event.selectedCategory.slug);

      emit(
        HomeLoaded(
          products: products,
          isAdded: false,
          categories: currentState?.categories ?? [],
          selectedCategory: event.selectedCategory,
          searchProductQuery: '',
          searchCategoryQuery: '',
          sortType: currentState?.sortType ?? ProductSortTypeEnum.none,
        ),
      );
    } catch (e) {
      emit(
        HomeError(
          e.toString(),
          isCategoriesView: false,
          selectedCategory: event.selectedCategory,
        ),
      );
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
            searchProductQuery: '',
            searchCategoryQuery: '',
            sortType: currentState.sortType,
          ),
        );
      } catch (e) {
        emit(
          HomeError(
            e.toString(),
            isCategoriesView: false,
            selectedCategory: event.selectedCategory,
          ),
        );
      }
    }
  }

  Future<void> _fetchCategories(
    FetchCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final currentState = state is HomeLoaded ? state as HomeLoaded : null;

      if (event.isFromProductsList &&
          (currentState is HomeLoaded && currentState.categories.isNotEmpty)) {
        emit(
          HomeLoaded(
            products: [],
            isAdded: false,
            categories: currentState.categories,
            selectedCategory: null,
            searchProductQuery: '',
            searchCategoryQuery: '',
            sortType: ProductSortTypeEnum.none,
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
            searchProductQuery: '',
            searchCategoryQuery: '',
            sortType: ProductSortTypeEnum.none,
          ),
        );
      }
    } catch (e) {
      emit(HomeError(e.toString(), isCategoriesView: true));
    }
  }

  Future<void> _searchProduct(
    SearchProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(
        HomeLoaded(
          products: currentState.products,
          isAdded: false,
          categories: currentState.categories,
          searchProductQuery: event.searchQuery,
          searchCategoryQuery: '',
          selectedCategory: currentState.selectedCategory,
          sortType: currentState.sortType,
        ),
      );
    }
  }

  Future<void> _searchCategory(
    SearchCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      emit(
        HomeLoaded(
          products: [],
          isAdded: false,
          categories: currentState.categories,
          searchProductQuery: '',
          searchCategoryQuery: event.searchQuery,
          selectedCategory: null,
          sortType: currentState.sortType,
        ),
      );
    }
  }

  Future<void> _sortProducts(
    SortProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      emit(
        HomeLoaded(
          products: currentState.products,
          isAdded: false,
          categories: currentState.categories,
          searchProductQuery: '',
          searchCategoryQuery: '',
          sortType: event.sortType,
          selectedCategory: currentState.selectedCategory,
        ),
      );
    }
  }

  Future<void> _deleteProduct(
    DeleteProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      final List<ProductEntity> updatedProducts = currentState.products
          .where((product) => product.id != event.productId)
          .toList();

      emit(
        HomeLoaded(
          products: updatedProducts,
          isAdded: false,
          categories: currentState.categories,
          searchProductQuery: currentState.searchProductQuery,
          searchCategoryQuery: '',
          sortType: currentState.sortType,
          selectedCategory: currentState.selectedCategory,
        ),
      );
    }
  }
}
