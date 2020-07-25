import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/product_details.dart';
import 'package:heron_delivery/src/pages/products_page.dart';
import 'package:heron_delivery/src/pages/tabs_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TabsPage());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      //case 'product':
      //  return MaterialPageRoute(builder: (_) => ProductsPage());
      // case 'product_detail':
      //  return MaterialPageRoute(builder: (_) => EditProduct());
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