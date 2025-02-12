import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/ui/cart_page_product_details_tile.dart';

class LoadedCartPage extends StatelessWidget {
  final CartBloc cartBloc;
  final CartSucessState cartSucessState;
  const LoadedCartPage({
    super.key,
    required this.cartSucessState,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartSucessState.cartItems.length,
              itemBuilder: (context, index) {
                return CartPageProductDetailsTile(
                    cartBloc: cartBloc,
                    productsDataModel: cartSucessState.cartItems[index]);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container()
        ],
      ),
    );
  }
}
