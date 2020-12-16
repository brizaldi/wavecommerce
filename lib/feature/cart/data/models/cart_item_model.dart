import 'package:meta/meta.dart';

import '../../../../core/constants/strings.dart';
import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    @required id,
    @required title,
    @required weight,
    @required imgPath,
    @required price,
    @required quantity,
  }) : super(
          id: id,
          title: title,
          weight: weight,
          imgPath: imgPath,
          price: price,
          quantity: quantity,
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      imgPath: json['img_path'] == ""
          ? Strings.imagePlaceholderUrl
          : json['img_path'],
      price: json['price'],
      title: json['title'],
      weight: json['weight'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_path': imgPath,
      'price': price,
      'title': title,
      'weight': weight,
      'quantity': quantity,
    };
  }

  String getFormattedPrice() {
    return "Rp $price";
  }

  String getTotalPrice() {
    final int total = int.parse(price) * quantity;
    return "Rp $total";
  }

  String getTotalWeight() {
    final double total = double.parse(weight) * quantity;
    return "$total kg";
  }
}
