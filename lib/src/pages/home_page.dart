import 'package:flutter/material.dart';
import 'package:heron_delivery/src/search/search_delegate.dart';

import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/pages/body_home_page.dart';
import 'package:heron_delivery/src/pages/favorito_page.dart';
import 'package:heron_delivery/src/share_prefs/prefs_user.dart';
import 'package:heron_delivery/src/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PrefsUser prefsUser = new PrefsUser();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    prefsUser.ultimaPagina = HomePage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    //peliculaProvider.getPopulares();

    return Scaffold(
        drawer: MenuWidget(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0), child: _appBar(context)),
        body: _crearPage(_selectedIndex),
        bottomNavigationBar: _bottonNavigationBar(context));
  }

  /// Dibujo la barra superior del home
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            padding: EdgeInsets.only(left: 10.0),
            icon: Icon(
              Icons.account_circle,
              size: 35.0,
              color: color.getColorBlueRGBO(),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        title: _location(),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(
                    Icons.search,
                    color: color.getColorBlueRGBO(),
                    size: 30.0,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: DataSearch(),
                      query: null,
                    );
                  })
            ],
          ),
        ],
        backgroundColor: color.getColorYellowRGBO());
  }

  /// Parametros de la localizacion actual del usuario registrado
  Widget _location() {
    return SafeArea(
        child: FlatButton.icon(
            textColor: color.getColorGrisRGBO(),
            onPressed: () {
              //navigator.pusshed
            },
            icon: Icon(
              Icons.location_on,
              color: color.getColorBlueHex(),
              size: 20.0,
            ),
            label: Text('Location')));
  }

  /// Retorna la pagina segun el indixe que reciba como parametro
  Widget _crearPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return BodyHomePage();
        break;
      case 1:
        return FavoritoPage();
        break;
      default:
        return BodyHomePage();
    }
  }

  /// Actualizo el estado del indixe de la barra nagedora y cambio de pagina
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Botones de navegacion de la app
  Widget _bottonNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 20.0,
        onTap: _onItemTapped, //envio la referencia a la funcion
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: color.getColorYellowRGBO(),
        selectedItemColor: color.getColorBlueHex(),
        unselectedItemColor: color.getColorGrisRGBO(),
        selectedFontSize: 15,
        unselectedFontSize: 13,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favoritos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('Pedidos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.share), title: Text('Share')),
        ]);
  }
}
