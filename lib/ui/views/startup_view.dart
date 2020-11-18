import 'package:flutter/material.dart';
import 'package:heron_delivery/core/services/auth/abst_auth.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:heron_delivery/ui/views/login_view.dart';

import 'package:heron_delivery/ui/views/tabs_view.dart';

import '../../locator.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  final AbstAuth _authenticationService =
      locator<AbstAuth>();
  //final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    _authenticationService.isUserLoggedIn().then((value) {
      if (value) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    }).catchError((e) => _navigateToLogin());
  }

  void _navigateToHome() {
    //_navigationService.navigateTopushReplacementNamed(RouteTabPage);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => TabsView()));
  }

  void _navigateToLogin() {
    //_navigationService.navigateTopushReplacementNamed(RouteLoginPage);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginView()));
  }

  

  @override
  Widget build(BuildContext context) {
    //valido si el usuario esta loggeado
    //lo dirigo a otra pagina
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child:
            Image.asset('assets/img/heron_delivery.png',
              fit: BoxFit.fitWidth,
            )
          ),
          Center(
            child: loadProgress
          )
        ],
      )
    );
  }
}
