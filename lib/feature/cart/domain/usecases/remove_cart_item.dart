import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class RemoveCartItem implements UseCase<void, Params> {
  final CartRepository cartRepository;

  RemoveCartItem(this.cartRepository);

  @override
  Future<Either<Failure, Cart>> call(Params params) {
    return cartRepository.removeCartItem(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
