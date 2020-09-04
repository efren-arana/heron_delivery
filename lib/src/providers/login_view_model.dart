
import 'package:flutter/foundation.dart';
import 'package:heron_delivery/src/services/authentication_service.dart';
import 'package:heron_delivery/src/services/dialog_service.dart';
import 'package:heron_delivery/src/services/navigation_service.dart';
import 'package:heron_delivery/src/utils/route_names.dart' as routes;

import '../../locator.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTopushReplacementNamed(routes.RootPageRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  Future navigateToSignPage(){
    return _navigationService.navigateTo(routes.SignUpPageRoute);
  }
}