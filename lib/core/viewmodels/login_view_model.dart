import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:heron_delivery/core/services/auth/abst_auth.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/core/constants/routes_name.dart' as routes;
import 'package:flutter/material.dart';
import 'package:heron_delivery/core/utils/validators.dart';
import 'package:heron_delivery/ui/shared/dialog_manager.dart';

import '../../locator.dart';
import '../providers/base_model.dart';

class LoginViewModel extends BaseModel with Validators {
  final AbstAuth _authenticationService = locator<AbstAuth>();

  final NavigationService _navigationService = locator<NavigationService>();
  GlobalKey<FormState> _formKey;
  bool _formValidated = false;

  bool get formValidated => _formValidated;

  LoginViewModel(this._formKey);

  ///Metodo que envio los datos a firebase para realizar la autenticacion
  Future<void> submitLoginForm({
    @required String email,
    @required String password,
  }) async {
    //Establezco un estado ocupado para la carga
    busy = true;
    //retorno si  hay errores en el formulario
    //esta validacion ya se encuentra en la vista
    // Se valida si el formulario esta validado para poder cambiar el color del boton
    //es redundante
    if (!_formKey.currentState.validate()) {
      busy = false;
      return;
    }

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );
    //evaluo el resultado.
    busy = false;
    _evaluateResult(result);
  }

  ///Medoto que realiza la autenticacion con facebook
  Future<void> loginFacebook() async {
    var result = await _authenticationService.signInWithFacebook();
    //evaluo el resultado
    _evaluateResult(result);
  }

  ///Evalua los resultado de la autenticacion para realizar alguna accion
  void _evaluateResult(dynamic result) {
    if (result is bool) {
      if (result) {
        _navigationService.navigateTopushReplacementNamed(routes.RouteTabView);
      } else {
        showMyAlertDialog("Login Fallido",
            "Falla genereal del login. Por favor intente de nuevo mas tarde!");
        //await _dialogService.showDialog(
        //  title: 'Login Failure',
        //  description: 'General login failure. Please try again later',
        //);
      }
    } else {
      showMyAlertDialog("Login Fallido", result.toString());
    }
    _formValidated = false;
    notifyListeners();
    return;
  }

  ///Verifica si el formulario esta validado
  void validateForm() {
    if (_formKey.currentState.validate()) {
      _formValidated = true;
    } else {
      _formValidated = false;
    }
    notifyListeners();
  }

  //meotod que realiza la navegacion a la pagina de registro
  Future navigateToSignPage() {
    return _navigationService.navigateTo(routes.RouteSignUpView);
  }
}
