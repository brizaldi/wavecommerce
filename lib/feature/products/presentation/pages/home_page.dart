import 'package:badges/badges.dart';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/strings.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../bloc/product/product_bloc.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.appName),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadSuccessState) {
                return _shoppingCartBadge(
                  context: context,
                  cartItemCount: state.cart.totalItems,
                );
              }

              return _shoppingCartBadge(context: context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionRow(
        color: Colors.blueAccent,
        children: <Widget>[
          FloatingActionRowButton(
            icon: Icon(
              Icons.list,
            ),
            onTap: () {},
          ),
          FloatingActionRowDivider(),
          FloatingActionRowButton(
            icon: Icon(
              Icons.sort,
            ),
            onTap: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitialState) {
            return Container();
          } else if (state is ProductLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoadSuccessState) {
            return GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<CartBloc>(context).add(
                      AddCartItemEvent(
                        product: state.productList[index],
                      ),
                    );
                  },
                  child: ProductCard(
                    key: ValueKey(index),
                    productModel: state.productList[index],
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            );
          } else if (state is ProductLoadFailedState) {
            return Center(
              child: Text(Strings.errorMessage),
            );
          } else {
            return Center(
              child: Text("Unexpected State"),
            );
          }
        },
      ),
    );
  }

  Widget _shoppingCartBadge(
      {@required BuildContext context, int cartItemCount = 0}) {
    if (cartItemCount > 0) {
      return Badge(
        position: BadgePosition.topEnd(top: 0, end: 3),
        animationDuration: Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          cartItemCount.toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
        ),
      );
    } else {
      return IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
      );
    }
  }
}
