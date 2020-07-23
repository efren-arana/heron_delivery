import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/models/category_model.dart';
import 'package:heron_delivery/src/models/news_models.dart';
import 'package:heron_delivery/src/pages/myflexiableappbar.dart';
import 'package:heron_delivery/src/providers/pelicula_provider.dart';
import 'package:heron_delivery/src/search/search_delegate.dart';
import 'package:heron_delivery/src/services/news_service.dart';
import 'package:heron_delivery/src/utils/color_util.dart' as color;
import 'package:heron_delivery/src/widgets/card_horizontal.dart';
import 'package:heron_delivery/src/widgets/card_page_view.dart';
import 'package:heron_delivery/src/widgets/card_swiper.dart';
import 'package:heron_delivery/src/widgets/lista_noticias.dart';
import 'package:heron_delivery/src/widgets/menu_widget.dart';
import 'package:provider/provider.dart';

class BodyHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  BodyHomePage({Key key, this.scaffoldKey}) : super(key: key);

  //GlobalKey<ScaffoldState> get scaffoldkey => this._scaffoldKey;

  @override
  _BodyHomePageState createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage>
    with AutomaticKeepAliveClientMixin {
  //final peliculaProvider = PeliculaProvider();
  /*
  void _closeDrawer() {
    Navigator.of(context).pop();
  }
*/

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //final headlines = Provider.of<NewsService>(context).headlines;
    /*
    return SafeArea(
      child: Scaffold(
          body: (headlines.length == 0)
              ? Center(child: CircularProgressIndicator())
              : _listarNoticias(headlines)),
    );
    */
    return SafeArea(child: Scaffold(body: _listarNoticias()));
  }

  _listarNoticias() {
    final newsService = Provider.of<NewsService>(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: Container(),
          actions: <Widget>[Container()],
          title: _barraSuperior(),
          pinned: true,
          expandedHeight: 210.0,
          flexibleSpace: FlexibleSpaceBar(
            background: MyFlexiableAppBar(),
          ),
        ),
        SliverToBoxAdapter(child: _ListaCategorias()),
        if (!newsService.isLoading)
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Noticia(
                  noticia: newsService.getArticulosCategoriaSeleccionada[index],
                  index: index);
            },
                childCount:
                    newsService.getArticulosCategoriaSeleccionada.length),
          ),
        if (newsService.isLoading)
          SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }

  _barraSuperior() {
    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                onPressed: widget.scaffoldKey.currentState.openDrawer,
                icon: Icon(FontAwesomeIcons.bars),
                color: Colors.white,
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'My Digital Currency',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 20.0),
              ),
            ),
          ),
          Expanded(child: Container()),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  FontAwesomeIcons.userCircle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics:
            BouncingScrollPhysics(), //para que el scroll sea igual que en android
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    //obtengo la instancia del servicio para cambiar el color de la categoria
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        // print('${ categoria.name }');
        //colocar el listen en false cuando el provider se encuentra en un tag
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
              ? color.getColorYellowRGBO()
              : Colors.black54,
        ),
      ),
    );
  }
}
