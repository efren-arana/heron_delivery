import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heron_delivery/src/providers/pelicula_provider.dart';
import 'package:heron_delivery/src/search/search_delegate.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/utils/font_util.dart' as font;
import 'package:heron_delivery/src/widgets/card_horizontal.dart';
import 'package:heron_delivery/src/widgets/card_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _sector = 'Tejerias';
  String _ciudad = 'Samborondon';

  final peliculaProvider = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    peliculaProvider.getPopulares();
    return Scaffold(
        appBar: _appBar(),
        body: _scrollBody(context),
        bottomNavigationBar: _bottonNavigationBar(context));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10.0),
          icon: Icon(
            Icons.account_circle,
            size: 40.0,
            color: color.getColorBlueHex(),
          ),
          onPressed: () {},
        ),
        title: _location(),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(
                    Icons.local_grocery_store,
                    color: color.getColorBlueRGBO(),
                    size: 40.0,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: DataSearch(),
                      query: null,
                    );
                  })
            ],
          ),
        ],
        backgroundColor: color.getColorYellowRGBO());
  }

  Widget _location() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Container(
                width: 70.0,
                child: Text('$_sector', style: font.getFontAppBar())),
            Container(
                width: 85.0,
                child: Text(',$_ciudad', style: font.getFontAppBar())),
            Icon(
              Icons.location_on,
              color: color.getColorBlueHex(),
              size: 20.0,
            )
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 3:
        showSearch(
          context: context,
          delegate: DataSearch(),
          query: null,
        );
        break;
      default:
    }
  }

  Widget _bottonNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: color.getColorYellowHex(),
        selectedItemColor: color.getColorBlueHex(),
        unselectedItemColor: color.getColorGrisRGBO(),
        selectedFontSize: 18,
        unselectedFontSize: 13,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favoritos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('Pedidos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Buscar')),
        ]);
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculaProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 300.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _pageView(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child:
                Text('Populares', style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(
            height: 5.0,
          ),
          //StreamBuilder: Se ejecuta cada vez que se emita un valor en el stream
          StreamBuilder(
            stream: peliculaProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CardHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina:
                      peliculaProvider.getPopulares, //definicion de la funcion
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }

  Widget _scrollBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate(
                [_swiperTarjetas(), _pageView(context)]))
      ],
    );
  }
}
