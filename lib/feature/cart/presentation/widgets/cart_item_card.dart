import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/stepo.dart';
import '../../data/models/cart_item_model.dart';
import '../bloc/cart/cart_bloc.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel cartItemModel;

  const CartItemCard({Key key, this.cartItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 80.0,
                width: 80.0,
                imageUrl: cartItemModel.imgPath,
                errorWidget: (context, url, error) => Icon(Icons.error),
                fadeInDuration: const Duration(milliseconds: 100),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItemModel.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItemModel.getTotalPrice(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '(Baru)',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stepo(
                            key: UniqueKey(),
                            width: 80,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            initialCounter: cartItemModel.quantity,
                            lowerBound: 1,
                            onIncrementClicked: (counter) {
                              BlocProvider.of<CartBloc>(context).add(
                                EditCartItemQuantityEvent(
                                  id: cartItemModel.id,
                                  quantity: cartItemModel.quantity + 1,
                                ),
                              );
                            },
                            onDecrementClicked: (counter) {
                              if (cartItemModel.quantity == 1) {
                                BlocProvider.of<CartBloc>(context).add(
                                  RemoveCartItemEvent(id: cartItemModel.id),
                                );
                              } else {
                                BlocProvider.of<CartBloc>(context).add(
                                  EditCartItemQuantityEvent(
                                    id: cartItemModel.id,
                                    quantity: cartItemModel.quantity - 1,
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 4.0),
                          Text(cartItemModel.getTotalWeight()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
