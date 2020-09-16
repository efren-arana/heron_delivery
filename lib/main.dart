import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heron_delivery/router.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart';
import 'package:heron_delivery/ui/views/startup_view.dart';
import 'package:provider/provider.dart';
import 'core/providers/cart_provider.dart';
import 'core/providers/category_provider.dart';
import 'core/providers/product_provider.dart';
import 'core/providers/shop_provider.dart';
import 'core/services/firestore_service.dart';
import 'locator.dart';

void main() async {
  //bloquea el giro de la pantalla en (android)
  //permite inicializar las preferencias del usuario
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final prefs = new PrefsUser();
  //await prefs.initPrefs();
  // Register all the models and services before the app starts
  setupLocator();
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
    //final firestoreService = FirestoreService('shops');
    // Establece el color de la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

    // This widget is the root of your application.
    return MultiProvider(
      providers: [
        //StreamProvider<User>(create: (context) => firestoreService.getProducts()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider())
      ],
      child: MaterialApp(
        title: 'Heron Delivery',
        //navigatorKey: locator<NavigationService>().navigationKey,
        theme: miTema,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        home: StartUpView(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
