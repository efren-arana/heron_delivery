import 'package:flutter/material.dart';
import 'package:heron_delivery/core/models/item_detail_model.dart';
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/ui/shared/card_product.dart';


class GridProductWidget extends StatelessWidget {
  final List<Item> items = [
    Item(price: 10.0,name: 'Laptop',idItem: 'IGvdWSEfQnkD6wHUNnCH'),
    Item(price: 20.0,name: 'iphone X',idItem: 'pP5PNiClUCnq4xqz1i3w'),
    Item(price: 15.0,name: 'Mouse',idItem: 'wjWcvHnuXUkYgspIKPl7')
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CardProduct(lineItem:new LineItem(item:items[index]),);
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
