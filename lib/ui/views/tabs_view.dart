import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/ui/views/home_view.dart';
import 'package:heron_delivery/ui/widgets/drawer_menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;

class TabsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //I have wrapped my widget with ChangeNotifierProvider
      //so my widget will be notified when the value changes.
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: true,
        drawer: DrawerMenuWidget(),
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
        backgroundColor: theme.getColorYellowRGBO,
        selectedItemColor: theme.getColorBlueHex,
        unselectedItemColor: theme.getColorGrisRGBO,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidHeart),
              title: Text('Favoritos')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.clipboardList) /*Icons.assignment*/,
              title: Text('Pedidos')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidQuestionCircle),
              title: Text('Soporte')),
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
      onPageChanged: (i) => navegacionModel.paginaActual = i,
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeView(scaffoldKey: scaffoldKey),
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

    //_pageController.animateToPage(valor,
    //    duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOutCubic
        );
    //notifico cuado se realice un cambio en el valor
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
