import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/data/wishlist_items.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_products_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(
      (event, emit) async {
        emit(WishlistLoadingState());
        await Future.delayed(Duration(seconds: 1));
        emit(WishlistPageLoadedState(wishlistedProducts: wishlistItems));
        if(wishlistItems.isEmpty){
          emit(WishlistEmptyState());
        }
      },
    );

    on<WishlistItemRemovedEvent>(
      (event, emit) {
        wishlistItems.remove(event.removedItem);
        emit(WishlistItemRemovedStata(removedProduct: event.removedItem.name));
        emit(WishlistPageLoadedState(wishlistedProducts: wishlistItems));
        if(wishlistItems.isEmpty){
          emit(WishlistEmptyState());
        }
      },
    );
  }
}
