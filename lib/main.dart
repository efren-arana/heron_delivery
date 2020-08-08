import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heron_delivery/src/pages/botton_navigation_bar.dart';
//import 'package:heron_delivery/src/pages/heron_delivery.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/products_page.dart';
import 'package:heron_delivery/src/pages/tabs_page.dart';
import 'package:heron_delivery/src/pages/user_location_page.dart';
import 'package:heron_delivery/src/providers/category_provider.dart';
import 'package:heron_delivery/src/providers/product_provider.dart';
import 'package:heron_delivery/src/providers/shop_provider.dart';
import 'package:heron_delivery/src/services/firestore_service.dart';
import 'package:heron_delivery/src/services/news_service.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/widgets/menu_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  //bloquea el giro de la pantalla en (android) y permite inicializar las preferencias del usuario
  WidgetsFlutterBinding.ensureInitialized();

  //final prefs = new PrefsUser();
  //await prefs.initPrefs();
  //bloquea el giro de la pantalla en (android)
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
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black));

    // This widget is the root of your application.
    return MultiProvider(
      providers: [
        StreamProvider(create: (context) => firestoreService.getProducts()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider())
      ],
      child: MaterialApp(
        //theme: ThemeData(primaryColor: color.getColorBlueRGBO()),
        debugShowCheckedModeBanner: false,
        title: 'Heron Delivery',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => TabsPage(),
          '/product': (BuildContext context) => ProductPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          //UserLocation.routeName: (BuildContext context) => UserLocation(),
        },
      ),
    );
  }
}
