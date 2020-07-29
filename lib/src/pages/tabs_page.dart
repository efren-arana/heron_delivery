import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/body1_home_page.dart';
import 'package:heron_delivery/src/pages/favorito_page.dart';
import 'package:heron_delivery/src/widgets/search_delegate.dart';
import 'package:heron_delivery/src/widgets/menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;

class TabsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //I have wrapped my widget with ChangeNotifierProvider 
      //so my widget will be notified when the value changes.
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: MenuWidget(),
        body: _Paginas(scaffoldKey: _scaffoldKey),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
        iconSize: 20.0,
        onTap: (i) =>
            navegacionModel.paginaActual = i, //envio la referencia a la funcion
        currentIndex: navegacionModel.paginaActual,
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

class _Paginas extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  //_Paginas({Key key,scaffoldkey this._scaffoldKey}):super(key:);
  _Paginas({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        BodyHomePage(scaffoldKey: scaffoldKey),
        FavoritoPage(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    //notifico cuado se realice un cambio en el valor
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
