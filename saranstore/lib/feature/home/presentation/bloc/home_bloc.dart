import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_products_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUsecase getProductsUsecase;

  HomeBloc({required this.getProductsUsecase})
      : super(HomeInitial()) {
    on<FetchProductsEvent>(_fetchProducts);
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
}