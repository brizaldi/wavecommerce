import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'feature/cart/data/data_sources/cart_local_data_source.dart';
import 'feature/cart/data/repositories/cart_repository_impl.dart';
import 'feature/cart/domain/repositories/cart_repository.dart';
import 'feature/cart/domain/usecases/add_cart_item.dart';
import 'feature/cart/domain/usecases/edit_cart_item_quantity.dart';
import 'feature/cart/domain/usecases/get_cart.dart';
import 'feature/cart/domain/usecases/remove_cart_item.dart';
import 'feature/cart/presentation/bloc/cart/cart_bloc.dart';
import 'feature/products/data/data_sources/product_remote_data_source.dart';
import 'feature/products/data/repositories/product_repository_impl.dart';
import 'feature/products/domain/repositories/product_repository.dart';
import 'feature/products/domain/usecases/get_all_products.dart';
import 'feature/products/presentation/bloc/product/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Products
  // Bloc
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      getAllProducts: sl(),
    ),
  );
  sl.registerFactory<CartBloc>(
    () => CartBloc(
      addCartItem: sl(),
      editCartItemQuantity: sl(),
      getCart: sl(),
      removeCartItem: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetAllProducts(sl()),
  );
  sl.registerLazySingleton(
    () => GetCart(sl()),
  );
  sl.registerLazySingleton(
    () => AddCartItem(sl()),
  );
  sl.registerLazySingleton(
    () => EditCartItemQuantity(sl()),
  );
  sl.registerLazySingleton(
    () => RemoveCartItem(sl()),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(cartLocalDataSourcce: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
