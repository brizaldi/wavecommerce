import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/cart_item_model.dart';

class Cart extends Equatable {
  final List<CartItemModel> items;
  final int totalPrice;
  final int totalItems;

  Cart({
    @required this.items,
    @required this.totalPrice,
    @required this.totalItems,
  });

  @override
  List<Object> get props => [
        items,
        totalPrice,
        totalItems,
      ];
}
