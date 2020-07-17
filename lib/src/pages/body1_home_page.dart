import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
        body: (headlines.length == 0)
            ? Center(child: CircularProgressIndicator())
            : _listarNoticias(headlines));
  }

  _listarNoticias(List<Article> noticias) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: _barraSuperior(),
          pinned: true,
          expandedHeight: 210.0,
          flexibleSpace: FlexibleSpaceBar(
            background: MyFlexiableAppBar(),
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Noticia(noticia: noticias[index], index: index);
          }, childCount: noticias.length),
        ),
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
