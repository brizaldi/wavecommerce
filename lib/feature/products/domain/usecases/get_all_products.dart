import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository productRepository;

  GetAllProducts(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams noParams) async {
    return await productRepository.getAllProducts();
  }
}
