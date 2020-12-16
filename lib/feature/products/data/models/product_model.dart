import 'package:meta/meta.dart';

import '../../../../core/constants/strings.dart';
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    @required id,
    @required title,
    @required description,
    @required userName,
    @required isHalal,
    @required weight,
    @required location,
    @required imgPath,
    @required price,
  }) : super(
          id: id,
          title: title,
          description: description,
          userName: userName,
          isHalal: isHalal,
          weight: weight,
          location: location,
          imgPath: imgPath,
          price: price,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      description: json['description'],
      imgPath: json['default_photo']['img_path'] == ""
          ? Strings.imagePlaceholderUrl
          : Strings.imageBaseUrl + json['default_photo']['img_path'],
      isHalal: json['is_halal'] == '1' ? true : false,
      location: json['location_name'],
      price: json['price'],
      title: json['title'],
      userName: json['added_user_name'],
      weight: json['weight'] == "" ? "0" : json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'default_photo': {
        'img_path': imgPath,
      },
      'is_halal': isHalal ? '1' : '0',
      'location_name': location,
      'price': price,
      'title': title,
      'added_user_name': userName,
      'weight': weight,
    };
  }

  String getFormattedPrice() {
    return "Rp $price";
  }
}
