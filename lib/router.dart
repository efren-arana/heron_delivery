import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/routes_name.dart' as routes;
import 'package:heron_delivery/ui/views/auth_phone_view.dart';
import 'package:heron_delivery/ui/views/check_out_view.dart';
import 'package:heron_delivery/ui/views/home_view.dart';
import 'package:heron_delivery/ui/views/login_view.dart';
import 'package:heron_delivery/ui/views/make_order_view.dart';
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
      case routes.RouteCheckoutView:
        return MaterialPageRoute(builder: (_) => CheckoutView());
      case routes.RouteMakeOrderView:
        return MaterialPageRoute(builder: (_) => MakeOrderView());
      case routes.RouteAuthPhoneView:
        return MaterialPageRoute(builder: (_) => AuthPhoneView());
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