import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/item_model.dart';
import 'package:heron_delivery/src/models/shop_model.dart';
import 'package:heron_delivery/src/shared/card_product.dart';

class GridProductWidget extends StatelessWidget {
  final List<Item> items = [
    Item(price: 18.0,name: 'Laptop'),
    Item(price: 18.0,name: 'iphone X'),
    Item(price: 18.0,name: 'Mouse')
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CardProduct(item:items[index],);
            },
            childCount: items.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.7,
          )),
    );
  }
}
