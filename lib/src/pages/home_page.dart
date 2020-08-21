import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/widgets/list_categories_widget.dart';
import 'package:heron_delivery/src/widgets/sliver_list_widget.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  HomePage({Key key, this.scaffoldKey}) : super(key: key);

  //GlobalKey<ScaffoldState> get scaffoldkey => this._scaffoldKey;

  @override
  _BodyHomePageState createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _SliverAppBar(widget: widget),
        ListCategoryWidget(),
        SliverListWidget(),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        iconSize: 30.0,
        onPressed: widget.scaffoldKey.currentState.openDrawer,
        icon: FaIcon(FontAwesomeIcons.bars),
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
          iconSize: 30.0,
          onPressed: () {
            print('IconButton');
          },
          icon: FaIcon(FontAwesomeIcons.search),
          color: Colors.white,
        ),
      ],
      //title: _barraSuperior(),
      pinned: true,
      expandedHeight: 210.0,
      flexibleSpace: FlexibleSpaceBar(
        //background: MyFlexiableAppBar(),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: AssetImage(
              'assets/img/sliver_app_bar.png'), //colacar la imagen de fonde de la tienda
          fit: BoxFit.contain,
          fadeInDuration: Duration(seconds: 1),
        ),
      ),
    );
  }
}
