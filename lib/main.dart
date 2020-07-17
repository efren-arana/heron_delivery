import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heron_delivery/src/pages/botton_navigation_bar.dart';
//import 'package:heron_delivery/src/pages/heron_delivery.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/tabs_page.dart';
import 'package:heron_delivery/src/pages/user_location_page.dart';
import 'package:heron_delivery/src/services/news_service.dart';
import 'package:heron_delivery/src/share_prefs/prefs_user.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/widgets/menu_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  //permite inicializar las preferencias del usuario
  WidgetsFlutterBinding
      .ensureInitialized(); //bloquea el giro de la pantalla en (android)

  //final prefs = new PrefsUser();
  //await prefs.initPrefs();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  //final prefs = new PrefsUser();
  @override
  Widget build(BuildContext context) {
    // Establece el color de la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => new NewsService())],
      child: MaterialApp(
        theme: ThemeData(primaryColor: color.getColorBlueRGBO()),
        debugShowCheckedModeBanner: false,
        title: 'Heron Delivery',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => TabsPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          UserLocation.routeName: (BuildContext context) => UserLocation(),
        },
      ),
    );
  }
}
