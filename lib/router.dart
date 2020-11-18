import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/routes_name.dart' as routes;
import 'package:heron_delivery/ui/views/buy_view.dart';
import 'package:heron_delivery/ui/views/check_out_view.dart';
import 'package:heron_delivery/ui/views/home_view.dart';
import 'package:heron_delivery/ui/views/login_view.dart';
import 'package:heron_delivery/ui/views/shopping_cart_view.dart';
import 'package:heron_delivery/ui/views/signup_view.dart';
import 'package:heron_delivery/ui/views/tabs_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routes.RouteTabView:
        return MaterialPageRoute(builder: (_) => TabsView());
      case routes.RouteHomeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case routes.RouteLoginView:
        return MaterialPageRoute(builder: (_) => LoginView());
      case routes.RouteSignUpView:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case '/items':
        return MaterialPageRoute(settings: settings, builder: (_) => ShoppingCartView());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutView());
      case '/buy':
        return MaterialPageRoute(settings: settings, builder: (_) => BuyView());
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