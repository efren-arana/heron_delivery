import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/models/category_model.dart';
import 'package:heron_delivery/src/pages/myflexiableappbar.dart';
import 'package:heron_delivery/src/providers/category_provider.dart';
import 'package:heron_delivery/src/widgets/list_categories.dart';
import 'package:heron_delivery/src/widgets/search_delegate.dart';
import 'package:heron_delivery/src/services/news_service.dart';
import 'package:heron_delivery/src/widgets/sliver_list.dart';
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
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(
      slivers: <Widget>[
        _SliverAppBar(widget: widget),
        ListCategoryWidget(),
        SliverListWidget(),
      ],
    )));
  }

  _listarNoticias() {
    final newsService = Provider.of<NewsService>(context);

    return null;
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

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final BodyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        iconSize: 30.0,
        onPressed: widget.scaffoldKey.currentState.openDrawer,
        icon: FaIcon(FontAwesomeIcons.userCircle),
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
          iconSize: 30.0,
          onPressed: () {
            showSearch(
              context: context,
              delegate: DataSearch(),
              query: null,
            );
          },
          icon: FaIcon(FontAwesomeIcons.search),
          color: Colors.white,
        ),
      ],
      //title: _barraSuperior(),
      pinned: true,
      expandedHeight: 210.0,
      flexibleSpace: FlexibleSpaceBar(
        background: MyFlexiableAppBar(),
      ),
    );
  }
}
