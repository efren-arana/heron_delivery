import 'package:flutter/material.dart';
import 'package:heron_delivery/src/providers/pelicula_provider.dart';
import 'package:heron_delivery/src/search/search_delegate.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/utils/font_util.dart' as font;
import 'package:heron_delivery/src/widgets/card_horizontal.dart';
import 'package:heron_delivery/src/widgets/card_page_view.dart';
import 'package:heron_delivery/src/widgets/card_swiper.dart';

class BodyHomePage extends StatelessWidget {
  final _sector = 'Tejerias';
  final _ciudad = 'Samborondon';
  final peliculaProvider = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), child: _appBar(context)),
      body: _singleChildScrollView(context),
    );
  }

  /// Dibujo la barra superior del home
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10.0),
          icon: Icon(
            Icons.account_circle,
            size: 35.0,
            color: color.getColorBlueHex(),
          ),
          onPressed: () {},
        ),
        title: GestureDetector(
          child: _location(),
          onTap: () {
            Navigator.pushNamed(context, 'user-location');
          },
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(
                    Icons.search,
                    color: color.getColorBlueRGBO(),
                    size: 30.0,
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

  /// Parametros de la localizacion actual del usuario registrado
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

  /// Crear la presentacion de anuncios
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

  /// Obtengo la lista de paginas de los servicios que se ofrecen
  Widget _pageView(context) {
    return FutureBuilder(
      future: peliculaProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardHorizontal(
            peliculas: snapshot.data,
            siguientePagina:
                peliculaProvider.getPopulares, //definicion de la funcion
          );
        } else {
          print('else: CircularProgressIndicator');
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /// Obtengo la lista de tarjetas
  Widget _cardPageView(BuildContext context) {
    return FutureBuilder(
      future: peliculaProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardPageView(
            peliculas: snapshot.data,
            siguientePagina:
                peliculaProvider.getPopulares, //definicion de la funcion
          );
        } else {
          print('else: CircularProgressIndicator');
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _singleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _swiperTarjetas(),
          SizedBox(height: 10.0),
          SizedBox(height: 200.0, child: _pageView(context)),
          Text(
            'Tus favoritos',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              height: 325.0,
              width: double.infinity,
              child: _cardPageView(context)),
          SizedBox(height: 200.0),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'),
                subtitle: Text('this is a description of the motivation')),
          )
        ],
      ),
    );
  }
}
