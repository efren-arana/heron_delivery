import 'package:flutter/material.dart';
import 'package:heron_delivery/src/models/product_model.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  const CardProduct({Key key,@required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10.0)),
      height: 5.0,
      alignment: Alignment.center,
      //color: Colors.teal[100 * (index % 9)],
      child: Text('grid item ${product.name}'),
    );
  }
}
