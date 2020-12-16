part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadSuccessState extends CartState {
  final Cart cart;

  CartLoadSuccessState({this.cart});

  @override
  List<Object> get props => [];
}

class CartLoadFailedState extends CartState {}
