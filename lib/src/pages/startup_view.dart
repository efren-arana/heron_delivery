import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/login_view.dart';
import 'package:heron_delivery/src/pages/tabs_page.dart';
import 'package:heron_delivery/src/services/authentication_service.dart';
import 'package:heron_delivery/src/services/navigation_service.dart';
import 'package:heron_delivery/src/utils/route_names.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
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
    });
  }

  void _navigateToHome() {
    //_navigationService.navigateTopushReplacementNamed(RouteTabPage);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => TabsPage()));
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
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/img/heron_delivery.png'),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(
                  Color(0xff19c7c1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
