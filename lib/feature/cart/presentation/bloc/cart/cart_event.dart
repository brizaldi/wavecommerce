part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {}

class AddCartItemEvent extends CartEvent {
  final Product product;

  AddCartItemEvent({this.product});

  @override
  List<Object> get props => [product];
}

class EditCartItemQuantityEvent extends CartEvent {
  final String id;
  final int quantity;

  EditCartItemQuantityEvent({this.id, this.quantity});

  @override
  List<Object> get props => [id, quantity];
}

class RemoveCartItemEvent extends CartEvent {
  final String id;

  RemoveCartItemEvent({this.id});

  @override
  List<Object> get props => [id];
}
