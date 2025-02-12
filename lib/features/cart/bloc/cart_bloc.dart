import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/data/cart_items.dart';
import 'package:flutter_bloc_tutorial/data/wishlist_items.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_products_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(
      (event, emit) async {
        emit(CartLoadingState());
        await Future.delayed(Duration(seconds: 1));
        if (cartItems.isEmpty) {
          emit(CartEmptyState());
        } else {
          emit(CartSucessState(cartItems: cartItems));
        }
      },
    );
    on<CartRemoveItemEvent>(
      (event, emit) {
        cartItems.remove(event.cartItemToBeDeleted);
        emit(CartItemRemovedState(productName: event.cartItemToBeDeleted.name));
        emit(CartSucessState(cartItems: cartItems));
        if (cartItems.isEmpty) {
          emit(CartEmptyState());
        }
      },
    );
  on<CartItemWishlistedEvent>((event, emit) {
    wishlistItems.add(event.wishlistedItem);
    emit(CartItemWishlistedState(wishlistedItemName: event.wishlistedItem.name));
  },);
    
  }
}
