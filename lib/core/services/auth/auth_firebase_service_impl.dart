import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:heron_delivery/core/models/user_model.dart';
import 'package:heron_delivery/core/services/auth/abst_auth.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/core/constants/routes_name.dart' as routes;

import '../../../locator.dart';
import '../abst_user_service.dart';

class AuthServiceFirebase implements AbstAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  //final FirestoreService _firestoreService = locator<FirestoreService>();
  final AbstUserService _firestoreService = locator<AbstUserService>();
  final NavigationService _navigationService = locator<NavigationService>();

  UserModel _currentUser;

  @override
  UserModel get currentUser => _currentUser;

  ///Metodo que realiza la autenticacion por correo
  ///Utiliza firebase_auth para realizar la autenticacion
  @override
  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  ///Metodo que notifica por medio de un flujo los cambios que ocurren en el usuario
  @override
  Stream<User> userChangesStream() {
    return _firebaseAuth.userChanges();
  }

  /// Metodo que realiza la autenticacion con facebook
  @override
  Future signInWithFacebook() async {
    //TODO: obtener la foto de perfil de facebook
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await _facebookAuth
          .login(permissions: const ['email', 'public_profile']);
      switch (loginResult.status) {
        case FacebookAuthLoginResponse.ok:
          break;
        case FacebookAuthLoginResponse.cancelled:
          return "login cancelled";
          break;
        default:
          return "login failed";
      }
      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      // Once signed in, return the UserCredential
      UserCredential authResult =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      // create a new user profile on firestore
      //TODO: obtener la foto de perfil de facebook
      _currentUser = new UserModel(
          userId: authResult.user.uid,
          email: authResult.user.email,
          fullName: authResult.user.displayName);

      return await _createUser(authResult.user, _currentUser);
    } catch (e) {
      return e.message;
    }
  }

  ///Metodo que registra un nuevo usuario
  @override
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = new UserModel(
          password: password,
          userId: authResult.user.uid,
          email: email,
          fullName: fullName);

      return await _createUser(authResult.user, _currentUser);
    } catch (e) {
      return e.message;
    }
  }

  /// Crear un usuario y realiza la validacion que el usuario se crear de manera correcta
  /// En caso que el usuario no se pueda crear lo elimina de la autenticacion
  /// Maneja las excepciones que se presentan en la eliminacion y en el registro de datos
  Future _createUser(User user, UserModel userModel) async {
    try {
      //creo un nuevo usuario
      //si el metodo trae un mensaje es por que ocurrio un error al registrarse
      await _firestoreService.setDocument(userModel.userId, userModel.toJson());
      return true;
    } catch (d) {
      try {
        user.delete();
        return false;
      } on FirebaseAuthException catch (e) {
        return e.message +'. '+ d.message;
      } catch (e) {
        return e.message +'. '+ d.message;
      }
    }
  }

  /// Metodo que utiliza el startup_view para validar la sesion del usuario
  @override
  Future<bool> isUserLoggedIn() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    var user = _firebaseAuth.currentUser;
    // Populate the user information
    await _populateCurrentUser(user);
    return user != null;
  }

  //Instancio el usuario autenticado
  Future<void> _populateCurrentUser(User user) async {
    // TODO: Crear algoritmo que obtenga los datos del usuario autenticado
    // Este algoritmo evita consultar la base de datos si ya se encuentra un usuario en cached
    // setear el modelo del usuario con los datos obtenido de firebase_auth
    //TODO: se tiene que validar si todos los datos del registro del usuario se guardan en cached
    if (user != null) {
      _currentUser = await _firestoreService.getUserById(user.uid);
    }
  }

  @override
  void signOut() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    if (accessToken != null) await _facebookAuth.logOut();
    _currentUser = null;
    _firebaseAuth.signOut().whenComplete(() => _navigationService
        .navigateTopushReplacementNamed(routes.RouteLoginView));
  }
}
