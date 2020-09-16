import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _icons = <String, IconData>{
  'Farmacias': FontAwesomeIcons.pills,
  'Tecnologia': FontAwesomeIcons.mobileAlt,
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'input': Icons.input,
  'list': Icons.list,
  'tune': Icons.tune,
};

FaIcon getIcon(String nombreIcono, Color color) {
  FaIcon iconData1;
  FaIcon iconData2;

  _icons.keys.forEach((element) {
    if (element.compareTo(nombreIcono) == 0) {
      iconData1 = FaIcon(_icons[nombreIcono], color: color);
    } else {
      iconData2 = FaIcon(Icons.add_alert, color: color);
    }
  });

  return iconData1 ?? iconData2;
}
