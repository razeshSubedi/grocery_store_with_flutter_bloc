import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home_page.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/wishlist_page_content_tile.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Wishlist"),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistItemRemovedStata) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text("${state.removedProduct} is removed from wishlist."),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    value: 20,
                  ),
                ),
              );

            case WishlistPageLoadedState:
              final wishlistLoadedState = state as WishlistPageLoadedState;

              return ListView.builder(
                itemCount: wishlistLoadedState.wishlistedProducts.length,
                itemBuilder: (context, index) {
                  return WishlistPageContentTile(
                    product: wishlistLoadedState.wishlistedProducts[index],
                    wishlistBloc: wishlistBloc,
                  );
                },
              );

            default:
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Wishlist is empty."),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Text(
                            "Click to add items.",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
