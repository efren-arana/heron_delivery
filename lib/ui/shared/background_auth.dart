import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;
import 'package:heron_delivery/ui/widgets/clipper_auth.dart';

/// Ckase que disena el fonde de nuestro login
class BackGroundAuth extends StatelessWidget {
  const BackGroundAuth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Image de la cabecera
    final headerImage = SafeArea(
        child: Container(
            width: double.infinity,
            height: size.height * 0.2,
            child: Image.asset(
              'assets/img/heron.png',
              fit: BoxFit.fitWidth,
            )));

    //clipper design de la curva
    final clipPath = ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        width: size.width,
        height: size.width * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              theme.getColorYellowRGBO,
              theme.getColorYellowGradient
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );

    //Columna que tiene la iamgen de cabecera y la curva en la parte inferior
    return Column(
      children: [
        Align(alignment: Alignment.topCenter, child: headerImage),
        Expanded(child: Container()),
        Align(alignment: Alignment.bottomCenter, child: clipPath)
      ],
    );
  }
}
