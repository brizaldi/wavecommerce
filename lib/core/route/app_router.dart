import 'package:flutter/material.dart';

import '../../feature/cart/presentation/pages/cart_page.dart';
import '../../feature/products/presentation/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == HomePage.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      );
    } else if (settings.name == CartPage.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return CartPage();
        },
      );
    }

    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}
