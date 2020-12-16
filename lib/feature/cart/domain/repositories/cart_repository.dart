import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> addCartItem(Product product);
  Future<Either<Failure, Cart>> editCartItemQuantity(String id, int quantity);
  Future<Either<Failure, Cart>> removeCartItem(String id);
  Future<Either<Failure, Cart>> getCart();
}
