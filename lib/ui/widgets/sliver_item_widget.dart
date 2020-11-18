import 'package:flutter/material.dart';
import 'package:heron_delivery/core/models/item_model.dart';
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
                        return Container(
                            width: double.infinity,
                            height: 30.0,
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Center(child: Text('${items[index].name}')));
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
