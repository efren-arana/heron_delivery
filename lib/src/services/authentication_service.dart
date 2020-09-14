import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:heron_delivery/src/models/user_model.dart';
import 'package:heron_delivery/src/services/firestore_service.dart';
import 'package:heron_delivery/src/services/navigation_service.dart';
import 'package:heron_delivery/src/utils/route_names.dart' as routes;

import '../../locator.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirestoreService _firestoreService = locator<FirestoreService>();
  final _firestoreService = FirestoreService('users');
  final NavigationService _navigationService = locator<NavigationService>();

  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

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
      _currentUser = UserModel(
        id: authResult.user.uid,
        email: email,
        fullName: fullName,
        userRole: role,
      );

      await _firestoreService.setDocument(
          _currentUser.id, _currentUser.toJson());

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
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
    _firebaseAuth.signOut().
    whenComplete(() => _navigationService.
      navigateTopushReplacementNamed(routes.RouteLoginPage)
      );
  }
}
