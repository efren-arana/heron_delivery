import 'package:flutter/material.dart';
import 'package:heron_delivery/core/providers/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heron_delivery/core/services/abst_user_service.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/core/utils/validators.dart';
import 'package:heron_delivery/ui/shared/dialog_manager.dart';

import '../../locator.dart';

class AuthPhoneViewModel extends BaseModel with Validators {
  final _codeController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  final AbstUserService _firestoreService = locator<AbstUserService>();

  /// Metodo que me valida el numero ingresado y realiza la autenticacion
  Future<void> verifyPhoneNumber(String phoneNumber) {
    dynamic phone = this.validatePhoneNumber(phoneNumber);
    
    if(phone is String){
      return _authPhoneNumber(phone);
    }else{
      return showMyAlertDialog("Verificacion fallida",
            "Formato del numero invalido. Por favor intente con un numero valido!");
    }  
  }

  Future<void> _authPhoneNumber(String phone) {
    return _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          //This callback would gets called when verification is done auto maticlly
          _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException exception) {
          //este callback se ejecuta si ocurrio un error al enviar el numer
          //ej: error en el formato del numeo
          //mostrar un dialogo con el error
          print('Exception:******************************\n$exception');
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          // dialogo para ingresar el codigo que se envio al diapositivo
          showDialog(
              context: _navigationService.navigationKey.currentContext,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final smsCode = _codeController.text.trim();
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);
                        Navigator.of(context).pop();
                        _signInWithCredential(credential);
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          //El sms nunca llego al dispositivo
          //TODO: Mostar un dialogo indicando el problema
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  Future<void> _signInWithCredential(AuthCredential credential) async {
    //TODO: actualizar el numero de telefono del usuario
    try {
      UserCredential result =
          await _auth.currentUser.linkWithCredential(credential);
      User user = result.user;
      print(
          "======================User firebase verifyPhoneNumber verificationCompleted========================");
      print('${user.toString()}');
      print("======================END User firebase========================");
      //quito  la pagina si la verificacion se completo
      if (user != null) {
        Map<dynamic, dynamic> data = {'phone_number': user.phoneNumber};
        _firestoreService.setDocument(user.uid, data, true, ['phone_number']);
        _navigationService.pop();
      } else {
        //TODO: mostrar un dialogo con el error
        print("Error");
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException:  ${e.message}');
      //TODO: mostrar dialogo con el error a mostrar
    }
  }
}
