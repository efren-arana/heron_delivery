import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/pages/home_page.dart';
import 'package:heron_delivery/src/pages/settings_page.dart';

class MenuWidget extends StatelessWidget {
  final _trailing = Icon(Icons.arrow_forward_ios);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SafeArea(
            child: DrawerHeader(
              child: Center(
                child: Container(
                  child: Text('Hola Denisse'),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      image: AssetImage('assets/img/drawerHeader2.png'),
                      fit: BoxFit.contain)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Perfil'),
            trailing: _trailing,
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_location),
            title: Text('Direcciones'),
            trailing: _trailing,
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.delicious),
            title: Text('Quiero vender en la App'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: Text('Quiero ser repartidor'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.cogs),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text('Cerrar sesion'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
