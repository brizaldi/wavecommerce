import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final String userName;
  final bool isHalal;
  final String weight;
  final String location;
  final String imgPath;
  final String price;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.userName,
    @required this.isHalal,
    @required this.weight,
    @required this.location,
    @required this.imgPath,
    @required this.price,
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        userName,
        isHalal,
        weight,
        location,
        imgPath,
        price,
      ];
}
