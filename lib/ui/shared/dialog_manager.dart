import 'package:flutter/material.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';

import '../../locator.dart';

NavigationService _navigationService = locator<NavigationService>();

/// Metodo que muestra un dialogo con los parametros que recibe
Future<void> showMyDialog(String title, String description) async {
  return showDialog<void>(
    context: _navigationService.navigationKey.currentContext,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              _navigationService.pop();
            },
          ),
        ],
      );
    },
  );
}
