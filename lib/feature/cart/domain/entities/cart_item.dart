import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CartItem extends Equatable {
  final String id;
  final String title;
  final String weight;
  final String imgPath;
  final String price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.weight,
    @required this.imgPath,
    @required this.price,
    @required this.quantity,
  });

  @override
  List<Object> get props => [
        id,
        title,
        weight,
        imgPath,
        price,
        quantity,
      ];
}
