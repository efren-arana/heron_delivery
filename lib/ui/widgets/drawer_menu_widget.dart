import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;
import 'package:heron_delivery/core/services/auth/abst_auth.dart';

import '../../locator.dart';

class DrawerMenuWidget extends StatelessWidget {
  final Function(BuildContext, int) onTap;
  final AbstAuth _authenticationService = locator<AbstAuth>();
  DrawerMenuWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    final _arrowtrailing = FaIcon(FontAwesomeIcons.arrowRight);

    return Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: new UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(
                        '${_authenticationService.currentUser.fullName.substring(0, 1)}',
                        style: theme.header2Style),
                backgroundColor: theme.getColorYellowRGBO,
                foregroundColor: theme.getColorBlueRGBO,
              ),
              decoration: BoxDecoration(color: Colors.transparent),
              accountName: Text(
                '${_authenticationService.currentUser.fullName}',
                style: theme.subHeaderStyle,
              ),
              accountEmail: Text('${_authenticationService.currentUser.email}'),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/drawer_menu-img.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              trailing: _arrowtrailing,
              onTap: () => onTap(context, 0)),
          Divider(),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.clipboardList),
              title: Text('Pedidos'),
              trailing: _arrowtrailing,
              onTap: () => null),
          Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text('Log out'),
            //trailing: _arrowtrailing,
            onTap: () => _authenticationService.signOut(),
          ),
          Divider(),
        ],
      ),
    );
  }
}
