/*
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:heron_delivery/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

  //constructor
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //informacion sobre propiedades del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 200.0,
      child: Swiper(
        autoplay: true,
        curve: Curves.easeInOut,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        //itemWidth: _screenSize.width * 1,
        //itemHeight: _screenSize.height * 0.4,
        //layout: SwiperLayout.TINDER,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-swiper';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'detalle',
                  arguments: peliculas[index]),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(peliculas[index].getbackdropPathImg()),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
*/