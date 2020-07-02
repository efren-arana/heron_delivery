import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heron_delivery/src/models/pelicula_model.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;

class CardPageView extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _decoration = BoxDecoration(
      color: Colors.black26, borderRadius: BorderRadius.circular(20.0));

  final _scrollController = ScrollController();
  final Function siguientePagina;

  CardPageView({@required this.peliculas, @required this.siguientePagina});

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

    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      itemCount: peliculas.length,
      itemBuilder: (context, i) {
        return _tarjeta(context, peliculas[i]);
      },
      //children: _tarjetas( context ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';

    final card = Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/jar-loading.gif'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    fadeInDuration: Duration(milliseconds: 500),
                    fit: BoxFit.cover,
                    height: 200.0,
                    width: 275.0,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 7.0),
                child: Text(
                  'Restauran $pelicula.title',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: color.getColorGrisRGBO(),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700),
                )),
            Container(
                padding: EdgeInsets.only(left: 7.0),
                child: Text(
                  'Postres $pelicula.title',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: color.getColorGrisRGBO(),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                )),
            Expanded(
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: _decoration,
                        child: Text(
                          ' ${pelicula.voteAverage}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: color.getColorGrisRGBO(),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: _decoration,
                        child: Text(
                          '${pelicula.voteCount}min',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: color.getColorGrisRGBO(),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: _decoration,
                      child: Row(
                        children: <Widget>[
                          Text(pelicula.voteAverage.toString()),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30.0,
                      ),
                      onPressed: () {})
                ],
              )),
            )
          ],
        ));

    final tarjeta = Container(
      width: 300.0,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: ClipRRect(child: card, borderRadius: BorderRadius.circular(20.0)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(5.0, 10.0))
          ]
          //color: Colors.red,
          ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
