import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/check_out_page.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/shopping_cart_page.dart';
import 'package:heron_delivery/src/pages/tabs_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TabsPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/items':
        return MaterialPageRoute(settings: settings, builder: (_) => ShoppingCartPage());
       case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}