import 'package:flutter/material.dart';
import 'package:heron_delivery/src/providers/pelicula_provider.dart';
import 'package:heron_delivery/src/search/search_delegate.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/utils/font_util.dart' as font;
import 'package:heron_delivery/src/widgets/card_horizontal.dart';
import 'package:heron_delivery/src/widgets/card_page_view.dart';
import 'package:heron_delivery/src/widgets/card_swiper.dart';

class HomePage extends StatefulWidget {
  final peliculaProvider = PeliculaProvider();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _sector = 'Tejerias';
  final _ciudad = 'Samborondon';

  @override
  Widget build(BuildContext context) {
    //peliculaProvider.getPopulares();

    return Scaffold(
        appBar: _appBar(context),
        body: _singleChildScrollView(context),
        bottomNavigationBar: _bottonNavigationBar(context));
  }

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
        //showSearch(
        //  context: context,
        //  delegate: DataSearch(),
        //  query: null,
        //);
        break;
      default:
    }
  }

  Widget _bottonNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 20.0,
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
      future: widget.peliculaProvider.getEnCines(),
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
    return FutureBuilder(
      future: widget.peliculaProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardHorizontal(
            peliculas: snapshot.data,
            siguientePagina:
                widget.peliculaProvider.getPopulares, //definicion de la funcion
          );
        } else {
          print('else: CircularProgressIndicator');
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _cardPageView(BuildContext context) {
    return FutureBuilder(
      future: widget.peliculaProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardPageView(
            peliculas: snapshot.data,
            siguientePagina:
                widget.peliculaProvider.getPopulares, //definicion de la funcion
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
