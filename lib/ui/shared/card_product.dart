import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/models/item_detail_model.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CardProduct extends StatelessWidget {
  final LineItem lineItem;
  const CardProduct({Key key, @required this.lineItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Using the above line in a build method
    //won’t cause this widget to rebuild when notifyListeners is called.
    final cart = Provider.of<Cart>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10.0)),
      height: 5.0,
      alignment: Alignment.center,
      //color: Colors.teal[100 * (index % 9)],
      child: Column(
        children: <Widget>[
          Text('grid item ${lineItem.itemName}'),
          Row(
            children: <Widget>[
              IconButton(
                icon: FaIcon(Icons.remove),
                onPressed: () => cart.removeItem(lineItem),
              ),
              Consumer<Cart>(
                builder: (context, cart, widget) {
                  return Text('${lineItem.cantSelected}');
                },
              ),
              IconButton(
                icon: FaIcon(Icons.add),
                onPressed: () => cart.addItem(lineItem),
              )
            ],
          ),
          FlatButton(
            color: Colors.red,
              onPressed: () => cart.add(lineItem), 
              child: Text('Agregar \$${lineItem.total}'))
        ],
      ),
    );
  }
}
