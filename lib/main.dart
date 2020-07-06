import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:heron_delivery/src/pages/heron_delivery.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/user_location_page.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //bloquea el giro de la pantalla en android
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Establece el color de la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
	  theme: ThemeData(
		primaryColor: Colors.red
	  ),
      debugShowCheckedModeBanner: false,
      title: 'Heron Delivery',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'user-location': (BuildContext context) => UserLocation(),
      },
    );
  }
}
