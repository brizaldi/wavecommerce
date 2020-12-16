import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class AddCartItem implements UseCase<void, Params> {
  final CartRepository cartRepository;

  AddCartItem(this.cartRepository);

  @override
  Future<Either<Failure, Cart>> call(Params params) {
    return cartRepository.addCartItem(params.product);
  }
}

class Params extends Equatable {
  final Product product;

  Params({@required this.product});

  @override
  List<Object> get props => [product];
}
