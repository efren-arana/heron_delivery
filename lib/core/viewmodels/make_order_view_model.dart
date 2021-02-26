import 'package:firebase_auth/firebase_auth.dart';
import 'package:heron_delivery/core/providers/base_model.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';

import '../../locator.dart';

class MakeOrderViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool _isValidated = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isValidated => _isValidated;

  /// Metodo que realiza la navegacion a la pagina para verificar el telefono
  Future navigateToAuthPhoneView() async {
    if (this.phoneNumberValidated) return;
    await _navigationService.navigateTo('/auth_phone');
  }

  String get phoneNumber {
    return (phoneNumberValidated) ? _auth.currentUser.phoneNumber : null;
  }

  //Valida si el phoneNumber se encuentra autenticado
  bool get phoneNumberValidated =>
      _auth.currentUser.phoneNumber != null &&
      _auth.currentUser.phoneNumber.length > 0;

  void _validated() {
    if (phoneNumberValidated) {
      _isValidated = true;
    } else {
      _isValidated = false;
    }
  }

  /// Metodo que realiza la transaccion para realizar el pedido
  Future makeOrder() {
    //TODO:
    //TODO:
    //TODO:
    //TODO:
    //TODO:
    //TODO:
    return Future.delayed(Duration(milliseconds: 3000));
    //TODO:
  }
}
