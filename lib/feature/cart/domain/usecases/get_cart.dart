import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCart implements UseCase<Cart, NoParams> {
  final CartRepository cartRepository;

  GetCart(this.cartRepository);

  @override
  Future<Either<Failure, Cart>> call(NoParams noParams) async {
    return await cartRepository.getCart();
  }
}
