import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../products/domain/entities/product.dart';
import '../../../domain/entities/cart.dart';
import '../../../domain/usecases/add_cart_item.dart' as add;
import '../../../domain/usecases/edit_cart_item_quantity.dart' as edit;
import '../../../domain/usecases/get_cart.dart' as get_cart;
import '../../../domain/usecases/remove_cart_item.dart' as remove;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    @required this.getCart,
    @required this.addCartItem,
    @required this.editCartItemQuantity,
    @required this.removeCartItem,
  }) : super(CartInitialState());

  final get_cart.GetCart getCart;
  final add.AddCartItem addCartItem;
  final edit.EditCartItemQuantity editCartItemQuantity;
  final remove.RemoveCartItem removeCartItem;

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is GetCartEvent) {
      print("GetCartEvent : called");
      yield CartLoadingState();
      final getCartFailedOrSuccess = await getCart(NoParams());
      yield getCartFailedOrSuccess.fold(
        (l) => CartLoadFailedState(),
        (r) => CartLoadSuccessState(cart: r),
      );
    } else if (event is AddCartItemEvent) {
      print("AddCartItemEvent : called");
      yield CartLoadingState();
      final addCartItemFailedOrSuccess = await addCartItem(
        add.Params(product: event.product),
      );
      yield addCartItemFailedOrSuccess.fold(
        (l) => CartLoadFailedState(),
        (r) => CartLoadSuccessState(cart: r),
      );
    } else if (event is EditCartItemQuantityEvent) {
      print("EditCartItemQuantityEvent : called");
      yield CartLoadingState();
      final editCartItemQuantityFailedOrSuccess = await editCartItemQuantity(
        edit.Params(
          id: event.id,
          quantity: event.quantity,
        ),
      );
      yield editCartItemQuantityFailedOrSuccess.fold(
        (l) => CartLoadFailedState(),
        (r) => CartLoadSuccessState(cart: r),
      );
    } else if (event is RemoveCartItemEvent) {
      print("RemoveCartItemEvent : called");
      yield CartLoadingState();
      final removeCartItemFailedOrSuccess = await removeCartItem(
        remove.Params(id: event.id),
      );
      yield removeCartItemFailedOrSuccess.fold(
        (l) => CartLoadFailedState(),
        (r) => CartLoadSuccessState(cart: r),
      );
    }
  }
}
