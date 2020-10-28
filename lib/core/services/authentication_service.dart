import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:heron_delivery/core/models/user_model.dart';
import 'package:heron_delivery/core/services/firestore_service.dart';
import 'package:heron_delivery/core/services/form_service.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;

import '../../locator.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirestoreService _firestoreService = locator<FirestoreService>();
  final _firestoreService = FirestoreService('users');
  final NavigationService _navigationService = locator<NavigationService>();
  final FormService formService = locator<FormService>();

  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  ///Metodo que realiza la autenticacion por correo
  ///Utiliza firebase_auth para realizar la autenticacion
  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    formService.reset();
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
  Stream<User> userChangesStream() {
    return _firebaseAuth.userChanges();
  }

  /// Metodo que realiza la autenticacion con facebook
  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: const ['email', 'public_profile']);
    switch (result.status) {
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
        FacebookAuthProvider.credential(result.accessToken.token);

    try {
      // Once signed in, return the UserCredential
      UserCredential authResult =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      // create a new user profile on firestore
      _currentUser = new UserModel(
          id: authResult.user.uid,
          email: authResult.user.email,
          fullName: authResult.user.displayName,
          userRole: authResult.additionalUserInfo.username);

      await _createNewUser();

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  ///Metodo que registra un nuevo usuario
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String role,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = new UserModel(
        id: authResult.user.uid,
        email: email,
        fullName: fullName,
        userRole: role,
      );

      await _createNewUser();

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  ///Metodo que crea un nuevo usuario,
  ///si el usuario ya existe en la base de datos lo setea
  Future _createNewUser() async {
    await _firestoreService.setDocument(_currentUser.id, _currentUser.toJson());
  }

  Future<bool> isUserLoggedIn() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});
    var user = _firebaseAuth.currentUser;
    // Populate the user information
    await _populateCurrentUser(user);
    return user != null;
  }

  //Instancio el usuario autenticado
  Future<void> _populateCurrentUser(User user) async {
    if (user != null) {
      DocumentSnapshot doc = await _firestoreService.getDocumentById(user.uid);
      _currentUser = UserModel.fromData(doc.data());
    }
  }

  void signOut() {
    _navigationService.pop();
    _firebaseAuth.signOut().whenComplete(() => _navigationService
        .navigateTopushReplacementNamed(routes.RouteLoginView));
  }
}
