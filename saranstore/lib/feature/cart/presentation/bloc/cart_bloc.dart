import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_event.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded(products: [])) {
    on<AddProductEvent>(_addProduct);
    on<RemoveProductEvent>(_removeProduct);
    on<IncreaseProductQuantityEvent>(_increaseProductQuantity);
    on<DecreaseProductQuantityEvent>(_decreaseProductQuantity);
  }

  Future<void> _addProduct(
    AddProductEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final List<CartItemEntity> products = currentState.products;
      final List<CartItemEntity> updatedProducts = [event.product, ...products];
      emit(CartLoaded(products: updatedProducts));
    }
  }

  Future<void> _removeProduct(
    RemoveProductEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final List<CartItemEntity> products = currentState.products;
      final List<CartItemEntity> updatedProducts = products
          .where((product) => product.product.id != event.product.product.id)
          .toList();
      emit(CartLoaded(products: updatedProducts));
    }
  }

  Future<void> _increaseProductQuantity(
    IncreaseProductQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final List<CartItemEntity> products = [];

      for (int i = 0; i < currentState.products.length; i++) {
        if (currentState.products[i].product.id == event.productId) {
          products.add(
            CartItemEntity(
              product: currentState.products[i].product,
              quantity: currentState.products[i].quantity < 1000
                  ? currentState.products[i].quantity + 1
                  : currentState.products[i].quantity,
            ),
          );
        } else {
          products.add(currentState.products[i]);
        }
      }

      emit(CartLoaded(products: products));
    }
  }

  Future<void> _decreaseProductQuantity(
    DecreaseProductQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final List<CartItemEntity> products = [];

      for (int i = 0; i < currentState.products.length; i++) {
        if (currentState.products[i].product.id == event.productId) {
          products.add(
            CartItemEntity(
              product: currentState.products[i].product,
              quantity: currentState.products[i].quantity - 1,
            ),
          );
        } else {
          products.add(currentState.products[i]);
        }
      }

      emit(CartLoaded(products: products));
    }
  }
}
