import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:heron_delivery/core/constants/theme/app_colors.dart';
import 'package:heron_delivery/core/services/authentication_service.dart';
import 'package:heron_delivery/core/services/form_service.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;

import '../../locator.dart';
import '../providers/base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FormService _formKeyService = locator<FormService>();
  bool _formValidated = false;
  //final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get formValidated => _formValidated;

  ///Metodo que envio los datos a firebase para realizar la autenticacion
  Future<void> submitForm({
    @required String email,
    @required String password,
  }) async {
    //Establezco un estado ocupado para la carga
    busy = true;
    //retorno si  hay errores en el formulario
    //esta validacion ya se encuentra en la vista
    //es redundante
    if (!_formKeyService.validate()) return;

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );
    //evaluo el resultado.
    _evaluateResult(result);
    busy = false;
  }

  ///Medoto que realiza la autenticacion con facebook
  Future<void> loginFacebook() async {
    //Establezco un estado ocupado para la carga
    busy = true;
    
    var result = await _authenticationService.signInWithFacebook();
    
    //evaluo el resultado
    _evaluateResult(result);
    busy = false;
  }

  ///Evalua los resultado de la autenticacion para realizar alguna accion
  void _evaluateResult(dynamic result) {
    if (result is bool) {
      if (result) {
        print(
            "====================================IF=========================");
        print("result: $result");
        print(
            "====================================end=========================");
        _navigationService
            .navigateTopushReplacementNamed(routes.RouteTabView);
        return;
      } else {
        print(
            "====================================else=========================");
        print("result: $result");
        print(
            "====================================end=========================");

        //await _dialogService.showDialog(
        //  title: 'Login Failure',
        //  description: 'General login failure. Please try again later',
        //);
        return;
      }
    } else {
      print(
          "====================================not boolean=========================");
      print("result: $result");
      print("====================================end=========================");
      return;
      //await _dialogService.showDialog(
      //  title: 'Login Failure',
      //  description: result,
      //);
    }
  }

  ///metodo que realiza las validacion de la contrasena
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

  ///Verifica si el formulario esta validado
  void validateForm() {
    if (_formKeyService.validate()) {
      _formValidated = true;
    } else {
      _formValidated = false;
    }
    notifyListeners();
  }


  ///Valida el patron del email
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

  //meotod que realiza la navegacion a la pagina de registro
  Future navigateToSignPage() {
    return _navigationService.navigateTo(routes.RouteSignUpView);
  }
}
