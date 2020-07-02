import 'package:flutter/material.dart';
import 'package:heron_delivery/src/pages/home_page.dart';

class HeronDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _pagina1(),
          HomePage(),
        ],
      ),
    );
  }

  Widget _pagina1() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/Heron_Imagotipo_1.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
