import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/core/viewmodels/home_view_model.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:heron_delivery/ui/widgets/sliver_category_widget.dart';
import 'package:heron_delivery/ui/widgets/sliver_item_widget.dart';
import 'package:heron_delivery/core/constants/theme/theme.dart' as theme;
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  HomeView({Key key, this.scaffoldKey}) : super(key: key);
  //GlobalKey<ScaffoldState> get scaffoldkey => this._scaffoldKey;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.getColorYellowRGBO,
          leading: IconButton(
            iconSize: 35.0,
            onPressed: widget.scaffoldKey.currentState.openDrawer,
            icon: FaIcon(
              Icons.menu,
              color: theme.getColorBlueRGBO,
            ),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(
                color: theme.getColorBlueRGBO,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          actions: <Widget>[_cartActionWidget(context)],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: solidDivider(context)),
            SliverItemCategoryWidget(),
            SliverToBoxAdapter(child: solidDivider(context)),
            SliverItemWidget(),
          ],
        ));
  }

  Widget _cartActionWidget(BuildContext context) {
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      height: 35.0,
      width: 35.0,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          new IconButton(
              iconSize: 35.0,
              icon: Icon(
                Icons.shopping_cart,
                color: theme.getColorBlueRGBO,
              ),
              onPressed: () => homeViewModel.navigateToCheckout()),
          Consumer<CartProvider>(
            builder: (context, cart, child) => Container(
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: (cart.count > 0) ? Colors.red : Colors.transparent),
              child: Center(
                  child: (cart.count > 0) ?
                  Text( '${cart.count}',style: TextStyle(fontSize: 14.0),)
                : Container(),
              ),
              alignment: Alignment.topLeft,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
