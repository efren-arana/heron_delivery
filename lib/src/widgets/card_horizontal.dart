/*
import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/shop_model.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;

class CardHorizontal extends StatelessWidget {
  final List<Shop> peliculas;
  final _scrollController = new ScrollController();

  final Function siguientePagina;

  CardHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    //informacion sobre propiedades del dispositivo

    final _screenSize = MediaQuery.of(context).size;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        siguientePagina(); //ejecuto getPopulares del provider
      }
    });

    void disponse() {
      _scrollController.dispose();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      controller: _scrollController,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: peliculas.length,
      itemBuilder: (context, i) {
        return _tarjeta(context, peliculas[i]);
      },
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';
    final tarjeta = Container(
      //height: 10.0,
      width: 80.0,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color.getColorGrisRGBO()),
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
  
}
*/