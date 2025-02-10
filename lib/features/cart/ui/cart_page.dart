import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          
        },
        builder: (context, state) {
          return Container();
        },
      ),

    );
  }
}