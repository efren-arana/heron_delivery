import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart';

final _icons = <String, Widget>{
  'BURGER': Container(
      child: FaIcon(FontAwesomeIcons.hamburger, color: Colors.amber[900])),
  'PIZZA': Container(
      child: FaIcon(FontAwesomeIcons.pizzaSlice, color: Colors.orange[600])),
  'FAST FOOD':
      Container(child: FaIcon(Icons.fastfood, color: Colors.green[900])),
  'TODO': Container(
      child: FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.yellow[600])),
  'BEBIDAS': Container(
      child: FaIcon(FontAwesomeIcons.wineBottle, color: Colors.purple[900])),
  'POSTRES': Container(
      child: FaIcon(FontAwesomeIcons.cookieBite, color: Colors.brown[700])),
  'MEXICANA': Container(
      child: FaIcon(FontAwesomeIcons.pepperHot, color: Colors.red[900])),
};

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget loadProgress = CircularProgressIndicator(
  strokeWidth: 3.0,
  valueColor: AlwaysStoppedAnimation(getColorBlueHex),
);

Widget getIcon(String nombreIcono) {
  Widget iconData1;
  Widget iconData2;
  String iconName = nombreIcono.toUpperCase();
  _icons.keys.forEach((element) {
    if (element.compareTo(iconName) == 0) {
      iconData1 = _icons[iconName];
    } else {
      iconData2 = Container(child: FaIcon(Icons.not_interested));
    }
  });

  return iconData1 ?? iconData2;
}

Widget solidDivider(BuildContext context) => Container(
      width: double.infinity,
      height: screenHeight(context) * 0.02,
      decoration: BoxDecoration(color: Colors.blueGrey[200]),
    );

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);
