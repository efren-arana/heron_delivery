import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/services/authentication_service.dart';
import 'package:heron_delivery/core/constants/route_names.dart' as routes;
import 'package:heron_delivery/ui/views/auth_phone_view.dart';
import 'package:heron_delivery/ui/views/settings_view.dart';

import '../../locator.dart';

class DrawerMenuWidget extends StatelessWidget {
  final _trailing = Icon(Icons.arrow_forward_ios);
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //new UserAccountsDrawerHeader(
                //    accountName: Text('accountName'),
                //    accountEmail: Text('accountEmail')),
                CircleAvatar(
                  maxRadius: 30.0,
                  child: Text('EA'),
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                ),
                Container(
                  child: Text('Hola Denisse'),
                ),
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/drawer_menu-img.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('VerifyPhoneNumber'),
            trailing: _trailing,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AuthPhoneView()));
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.sign),
            title: Text('Sign'),
            trailing: _trailing,
            onTap: () {
              Navigator.pushNamed(context, routes.RouteSignUpView);
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.userNinja),
            title: Text('Login'),
            trailing: _trailing,
            onTap: () {
              Navigator.pushNamed(context, routes.RouteLoginView);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Perfil'),
            trailing: _trailing,
            onTap: () {
              //Navigator.pushReplacementNamed(context, HomePage.routeName);
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
              Navigator.pushReplacementNamed(context, SettingsView.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text('Cerrar sesion'),
            onTap: () {
              _authenticationService.signOut();
            },
          )
        ],
      ),
    );
  }
}
