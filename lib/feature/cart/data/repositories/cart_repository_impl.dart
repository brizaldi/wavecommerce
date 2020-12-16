import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource cartLocalDataSourcce;

  CartRepositoryImpl({
    @required this.cartLocalDataSourcce,
  });

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      return Right(await cartLocalDataSourcce.getCart());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> addCartItem(Product product) async {
    try {
      return Right(await cartLocalDataSourcce.addCartItem(product));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> editCartItemQuantity(
    String id,
    int quantity,
  ) async {
    try {
      return Right(
        await cartLocalDataSourcce.editCartItemQuantity(
          id,
          quantity,
        ),
      );
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> removeCartItem(String id) async {
    try {
      return Right(await cartLocalDataSourcce.removeCartItem(id));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
