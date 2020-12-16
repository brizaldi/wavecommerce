import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_all_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({@required this.getAllProducts}) : super(ProductInitialState());

  final GetAllProducts getAllProducts;

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetProductListEvent) {
      print("GetProductListEvent : called");
      yield ProductLoadingState();
      final productListFailedOrSuccess = await getAllProducts(NoParams());
      yield productListFailedOrSuccess.fold(
        (l) => ProductLoadFailedState(),
        (r) => ProductLoadSuccessState(productList: r),
      );
    }
  }
}
