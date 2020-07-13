import 'package:flutter/material.dart';

class FavoritoPage extends StatelessWidget {
  const FavoritoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Favorito Home Page!!',
            style: TextStyle(fontSize: 50.0),
          ),
        ),
      ),
    );
  }
}
