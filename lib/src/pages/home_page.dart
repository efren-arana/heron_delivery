import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/body_home_page.dart';
import 'package:heron_delivery/src/pages/favorito_page.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //peliculaProvider.getPopulares();

    return Scaffold(
        body: _crearPage(_selectedIndex),
        bottomNavigationBar: _bottonNavigationBar(context));
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
              icon: Icon(Icons.local_grocery_store), title: Text('Carrito')),
        ]);
  }
}
