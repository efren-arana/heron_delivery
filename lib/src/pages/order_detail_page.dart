import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heron_delivery/src/providers/cart_provider.dart';
import 'package:heron_delivery/src/services/transaction.dart' as data;

class OrderDetailPage extends StatelessWidget {
  final Cart cart;
  final String shopId;
  OrderDetailPage({Key key, this.cart, this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<DocumentSnapshot>(
      future: data.addOrder(shopId: shopId, cart: cart),
      //initialData: InitialData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        DocumentSnapshot order = snapshot.data;
        return Container(
          child: Text('${order.data()}'),
        );
      },
    ),
    );

    
  }
}
