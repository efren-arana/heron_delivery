import 'package:flutter/foundation.dart';
import 'package:heron_delivery/core/services/authentication_service.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;

import '../../locator.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  //final DialogService _dialogService = locator<DialogService>();
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
        _navigationService.navigateTopushReplacementNamed(routes.RouteTabView);
        return true;
      } else {
        return result;
        //await _dialogService.showDialog(
        //  title: 'Login Failure',
        //  description: 'General login failure. Please try again later',
        //);
      }
    } else {
      return result;
      //await _dialogService.showDialog(
      //  title: 'Login Failure',
      //  description: result,
      //);
    }
  }

  ///metod que valida la contrasena
  String validatePwd(value) {
    if (value.toString().isEmpty) {
      return 'Campo obligatorio';
    } else if (value.toString().length < 6) {
      return 'Minimo 6 caracteres';
    } else if (value.toString().length > 15) {
      return 'Maximo 15 caracteres';
    } else {
      return null;
    }
  }

  void submitForm() {
    return null;
    /*
    //retorno si no hay errores en el formulario
    if (!formKey.currentState.validate()) return;

    //salva los valores de todos los campos del formulario
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    // setState(() {_guardando = false; });

    //Navigator.pop(context);
    */
  }

  String validateEmail(email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern); //expresion regular

    if (regExp.hasMatch(email)) {
      return null;
    } else {
      return 'Email no es correcto';
    }
  }

  Future navigateToSignPage() {
    return _navigationService.navigateTo(routes.RouteSignUpView);
  }
}
