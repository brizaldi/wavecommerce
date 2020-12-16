import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../core/constants/strings.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  static const routeName = '/CartPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.shoppingCart),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          if (cartState is CartInitialState) {
            return Container();
          } else if (cartState is CartLoadSuccessState) {
            return SlidingSheet(
              elevation: 8,
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                initialSnap: 1.0,
                positioning: SnapPositioning.relativeToSheetHeight,
              ),
              body: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                  8.0,
                  8.0,
                  8.0,
                  100.0,
                ),
                itemCount: cartState.cart.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartItemCard(
                    cartItemModel: cartState.cart.items[index],
                  );
                },
              ),
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total harga',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp ${cartState.cart.totalPrice}",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        height: 50.0,
                        minWidth: 120.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Order',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (cartState is CartLoadFailedState) {
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
}
