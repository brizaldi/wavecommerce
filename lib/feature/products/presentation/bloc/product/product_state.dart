part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadSuccessState extends ProductState {
  final List<Product> productList;

  ProductLoadSuccessState({this.productList});

  @override
  List<Object> get props => [];
}

class ProductLoadFailedState extends ProductState {}
