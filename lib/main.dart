import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heron_delivery/src/providers/cart_provider.dart';
import 'package:heron_delivery/src/providers/category_provider.dart';
import 'package:heron_delivery/src/providers/product_provider.dart';
import 'package:heron_delivery/src/providers/shop_provider.dart';
import 'package:heron_delivery/src/routes/router.dart';
import 'package:heron_delivery/src/services/firestore_service.dart';
import 'package:heron_delivery/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() async {
  //bloquea el giro de la pantalla en (android)
  //permite inicializar las preferencias del usuario
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final prefs = new PrefsUser();
  //await prefs.initPrefs();

  //Realiza el giro de la pantalla en (android) probar en iOS
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  //final prefs = new PrefsUser();

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService('shops');
    // Establece el color de la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

    // This widget is the root of your application.
    return MultiProvider(
      providers: [
        StreamProvider(create: (context) => firestoreService.getProducts()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider())
      ],
      child: MaterialApp(
        theme: miTema,
        debugShowCheckedModeBanner: false,
        title: 'Heron Delivery',
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
