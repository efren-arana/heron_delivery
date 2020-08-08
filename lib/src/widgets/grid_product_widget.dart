import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/product_model.dart';
import 'package:heron_delivery/src/models/shop_model.dart';
import 'package:heron_delivery/src/shared/card_product.dart';

class GridProductWidget extends StatelessWidget {

  const GridProductWidget({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CardProduct(product: new Product(),);
            },
            childCount: 10,
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
