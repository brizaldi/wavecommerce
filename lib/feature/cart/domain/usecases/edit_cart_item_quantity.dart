import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class EditCartItemQuantity implements UseCase<void, Params> {
  final CartRepository cartRepository;

  EditCartItemQuantity(this.cartRepository);

  @override
  Future<Either<Failure, Cart>> call(Params params) {
    return cartRepository.editCartItemQuantity(params.id, params.quantity);
  }
}

class Params extends Equatable {
  final String id;
  final int quantity;

  Params({@required this.id, @required this.quantity});

  @override
  List<Object> get props => [id, quantity];
}
