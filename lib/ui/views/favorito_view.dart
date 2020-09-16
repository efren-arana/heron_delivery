import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritoView extends StatelessWidget {
  final User user;
  const FavoritoView({Key key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(child: Text(''),),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Favorito Home Page!!\n${user.phoneNumber}',
            style: TextStyle(fontSize: 50.0),
          ),
        ),
      ),
    );
  }
}
