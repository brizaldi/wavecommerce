import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../products/data/models/product_model.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getCart();

  Future<CartModel> addCartItem(ProductModel productModel);

  Future<CartModel> editCartItemQuantity(String id, int quantity);

  Future<CartModel> removeCartItem(String id);
}

const CACHED_CART = 'CACHED_CART';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({@required this.sharedPreferences});

  Future<CartModel> _cacheCart(CartModel cartToCache) {
    sharedPreferences.setString(
      CACHED_CART,
      json.encode(cartToCache),
    );
    return Future.value(cartToCache);
  }

  @override
  Future<CartModel> getCart() {
    final jsonString = sharedPreferences.getString(CACHED_CART);
    if (jsonString != null) {
      return Future.value(CartModel.fromJson(json.decode(jsonString)));
    } else {
      final emptyCartModel = CartModel(
        items: <CartItemModel>[],
        totalPrice: 0,
        totalItems: 0,
      );
      return _cacheCart(emptyCartModel);
    }
  }

  CartModel _initNewCart(List<CartItemModel> items) {
    return CartModel(
      items: items,
      totalItems: _calculateTotalItems(items),
      totalPrice: _calculateTotalPrice(items),
    );
  }

  static int _calculateTotalPrice(List<CartItemModel> items) {
    final int price = items.fold(
      0,
      (accumulator, item) =>
          accumulator + (item.quantity * int.parse(item.price)),
    );

    return price;
  }

  static int _calculateTotalItems(List<CartItemModel> items) {
    return items.length;
  }

  @override
  Future<CartModel> addCartItem(ProductModel productModel) async {
    final cartModel = await getCart();
    final items = cartModel.items;
    final existedItem =
        items.firstWhere((i) => i.id == productModel.id, orElse: () => null);

    if (existedItem != null) {
      final newItems = items.map((oldItem) {
        if (oldItem.id == productModel.id) {
          return CartItemModel(
            id: oldItem.id,
            imgPath: oldItem.imgPath,
            price: oldItem.price,
            quantity: oldItem.quantity + 1,
            title: oldItem.title,
            weight: oldItem.weight,
          );
        } else {
          return oldItem;
        }
      }).toList();

      return _cacheCart(_initNewCart(newItems));
    } else {
      final newItems = List.of(items);
      newItems.add(
        CartItemModel(
          id: productModel.id,
          title: productModel.title,
          weight: productModel.weight,
          imgPath: productModel.imgPath,
          price: productModel.price,
          quantity: 1,
        ),
      );

      return _cacheCart(_initNewCart(newItems));
    }
  }

  @override
  Future<CartModel> editCartItemQuantity(String id, int quantity) async {
    final cartModel = await getCart();
    final items = cartModel.items;
    final newItems = items.map((oldItem) {
      if (oldItem.id == id) {
        return CartItemModel(
          id: oldItem.id,
          imgPath: oldItem.imgPath,
          price: oldItem.price,
          quantity: quantity,
          title: oldItem.title,
          weight: oldItem.weight,
        );
      } else {
        return oldItem;
      }
    }).toList();

    return _cacheCart(_initNewCart(newItems));
  }

  @override
  Future<CartModel> removeCartItem(String id) async {
    final cartModel = await getCart();
    final items = cartModel.items;
    final newItems = items.where((item) => item.id != id).toList();

    return _cacheCart(_initNewCart(newItems));
  }
}
