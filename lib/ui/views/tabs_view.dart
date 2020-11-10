import 'package:flutter/material.dart';
import 'package:heron_delivery/core/viewmodels/tabs_view_model.dart';
import 'package:heron_delivery/ui/views/auth_phone_view.dart';
import 'package:heron_delivery/ui/views/home_view.dart';
import 'package:heron_delivery/ui/widgets/drawer_menu_widget.dart';
import 'package:provider/provider.dart';

class TabsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //I have wrapped my widget with ChangeNotifierProvider
      //so my widget will be notified when the value changes.
      create: (_) => new TabViewModel(),
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: true,
        drawer: Consumer<TabViewModel>(
          builder: (context, model, child) =>
            DrawerMenuWidget(onTap: (context, index) {
              model.paginaActual = index;
              Navigator.pop(context);
          }),
        ),
        body: _PageViewWidget(scaffoldKey: _scaffoldKey),
      ),
    );
  }
}

class _PageViewWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  //_PageViewWidget({Key key,scaffoldkey this._scaffoldKey}):super(key:);
  _PageViewWidget({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<TabViewModel>(context);

    return PageView(
      onPageChanged: (i) => navegacionModel.paginaActual = i,
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[HomeView(scaffoldKey: scaffoldKey), AuthPhoneView()],
    );
  }
}

/*
class _ButtomNavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);
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
*/
