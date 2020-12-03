import 'package:flutter/material.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/core/viewmodels/home_view_model.dart';
import 'package:heron_delivery/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class SliverItemWidget extends StatefulWidget {
  SliverItemWidget({Key key}) : super(key: key);

  @override
  _SliverItemWidgetState createState() => _SliverItemWidgetState();
}

class _SliverItemWidgetState extends State<SliverItemWidget> {
  HomeViewModel _homeModelProvider = locator<HomeViewModel>();
  @override
  void initState() {
    _homeModelProvider.fetchItemsAsStream('Todo');
    super.initState();
  }

  @override
  void dispose() {
    _homeModelProvider.cerrar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final _screenSize = MediaQuery.of(context).size;
    List<ItemModel> items;
    return Consumer<HomeViewModel>(
        builder: (context, model, child) => (model.busy)
            ? child
            : StreamBuilder<List<ItemModel>>(
                stream: model.items,
                builder: (context, AsyncSnapshot<List<ItemModel>> snapshot) {
                  if (snapshot.hasData) {
                    items = snapshot.data;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return _CardItemWidget(itemModel: items[index]);
                      }, childCount: items.length),
                    );
                  } else {
                    return SliverFillRemaining(
                      child: Container(
                        child: Center(child: loadProgress),
                      ),
                    );
                  }
                },
              ),
        child: SliverFillRemaining(
          child: Container(
            child: Center(child: loadProgress),
          ),
        ));
  }
}

class _CardItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  const _CardItemWidget({Key key, @required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: LimitedBox(
        maxHeight: _size.height * 0.25,
        maxWidth: _size.width * 0.55,
        child: Consumer<CartProvider>(
          builder:(context,cart,child) => Container(
            color:
                cart.isSelected(itemModel) ? Colors.green[50] : Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  child: Image(
                    fit: BoxFit.contain,
                    alignment: Alignment.topLeft,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                  ),
                ),
                Flexible(child: detailItemContainer())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailItemContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                "${itemModel.name}",
                style: TextStyle(
                    color: Color(0xffe6020a),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                '${itemModel.description}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              )),
          Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                "Precio  \u0024 " + "${itemModel.unitPriceSale}",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Consumer<CartProvider>(
            builder: (context,cart,child) => Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  (cart.isSelected(itemModel))
                      ? Container()
                      : _addItemButton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addItemButton() {
    return Consumer<CartProvider>(
      builder: (context,cart,child) => Container(
        color: Colors.blue,
        child: FlatButton(
            color: Colors.red,
            onPressed: () => cart.addItemsToList(itemModel),
            child: Text('Agregar')),
      ),
    );
  }
}
