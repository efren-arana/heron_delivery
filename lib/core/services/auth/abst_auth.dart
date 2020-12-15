import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heron_delivery/core/models/user_model.dart';

abstract class AbstAuth {
  UserModel get currentUser => null;

  ///Metodo que realiza la autenticacion por correo
  ///Utiliza firebase_auth para realizar la autenticacion
  Future loginWithEmail({
    @required String email,
    @required String password,
  });

  ///Metodo que notifica por medio de un flujo los cambios que ocurren en el usuario
  Stream<User> userChangesStream();

  /// Metodo que realiza la autenticacion con facebook
  Future signInWithFacebook();

  ///Metodo que registra un nuevo usuario
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
  });

  /// Metodo que utiliza el startup_view para validar la sesion del usuario
  Future<bool> isUserLoggedIn();

  void signOut();
}
