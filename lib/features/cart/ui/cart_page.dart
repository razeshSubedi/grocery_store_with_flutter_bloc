import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/ui/cart_page_product_details_tile.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartItemRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("The item is removed from the cart."),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  value: 20,
                ),
              );

            case CartSucessState:
              final cartSucessState = state as CartSucessState;
              return ListView.builder(
                itemCount: cartSucessState.cartItems.length,
                itemBuilder: (context, index) {
                  return CartPageProductDetailsTile(
                      cartBloc: cartBloc,
                      productsDataModel: cartSucessState.cartItems[index]);
                },
              );

            case CartEmptyState:
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "The cart is empty.",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          "Click here to add items.",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 6, 105, 185),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );

            default:
              return Center(
                child: Text("Error in cartpagestate"),
              );
          }
        },
      ),
    );
  }
}
