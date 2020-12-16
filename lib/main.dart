import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/strings.dart';
import 'core/route/app_router.dart';
import 'feature/cart/presentation/bloc/cart/cart_bloc.dart';
import 'feature/products/presentation/bloc/product/product_bloc.dart';
import 'feature/products/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => sl<ProductBloc>()..add(GetProductListEvent()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => sl<CartBloc>()..add(GetCartEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
