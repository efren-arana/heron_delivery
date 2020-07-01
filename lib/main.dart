import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heron_delivery/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //cambia el color de la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heron Delivery',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
