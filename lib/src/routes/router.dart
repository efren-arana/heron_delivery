import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/buy_page.dart';
import 'package:heron_delivery/src/pages/check_out_page.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/login_view.dart';
import 'package:heron_delivery/src/pages/shopping_cart_page.dart';
import 'package:heron_delivery/src/pages/signup_view.dart';
import 'package:heron_delivery/src/pages/tabs_page.dart';
import 'package:heron_delivery/src/utils/route_names.dart' as routes;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routes.RouteTabPage:
        return MaterialPageRoute(builder: (_) => TabsPage());
      case routes.RouteHomePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case routes.RouteLoginPage:
        return MaterialPageRoute(builder: (_) => LoginView());
      case routes.RouteSignUpPage:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case '/items':
        return MaterialPageRoute(settings: settings, builder: (_) => ShoppingCartPage());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      case '/buy':
        return MaterialPageRoute(settings: settings, builder: (_) => BuyPage());
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