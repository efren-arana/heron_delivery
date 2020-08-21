import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/item_detail_model.dart';
import 'package:heron_delivery/src/models/item_model.dart';
import 'package:heron_delivery/src/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CardProduct extends StatelessWidget {
  final Item item;
  const CardProduct({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Using the above line in a build method 
    //won’t cause this widget to rebuild when notifyListeners is called.
    final cart = Provider.of<Cart>(context);

    return GestureDetector(
      onTap: () => cart.add(item),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(10.0)),
        height: 5.0,
        alignment: Alignment.center,
        //color: Colors.teal[100 * (index % 9)],
        child: Text('grid item ${item.name}'),
      ),
    );
  }
}
