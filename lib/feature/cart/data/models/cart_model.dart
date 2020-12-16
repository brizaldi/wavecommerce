import 'package:meta/meta.dart';

import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

class CartModel extends Cart {
  CartModel({
    @required items,
    @required totalPrice,
    @required totalItems,
  }) : super(
          items: items,
          totalPrice: totalPrice,
          totalItems: totalItems,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: List<CartItemModel>.from(
        json['items'].map((i) => CartItemModel.fromJson(i)),
      ),
      totalPrice: json['total_price'],
      totalItems: json['total_items'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> _items =
        this.items != null ? this.items.map((i) => i.toJson()).toList() : null;

    return {
      'items': _items,
      'total_price': totalPrice,
      'total_items': totalItems,
    };
  }

  String getFormattedTotalPrice() {
    return "Rp $totalPrice";
  }
}
