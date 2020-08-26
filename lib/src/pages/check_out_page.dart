import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/src/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(icon: FaIcon(FontAwesomeIcons.trash), 
                onPressed: ()=> cart.removeAll())
              ],
              title: Text('Checkout Page [\$ ${cart.subTotal}]'),
            ),
            body: cart.basketItems.length == 0
                ? Text('no items in your cart')
                : ListView.builder(
                    itemCount: cart.basketItems.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        child: Card(
                          child: ListTile(
                            leading: Text(cart.basketItems[index].total.toString()),
                            title: Text(cart.basketItems[index].itemName),
                            subtitle:
                                Text(cart.basketItems[index].itemPrice.toString()),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                cart.remove(cart.basketItems[index]);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: ()  => Navigator.pushNamed(context, '/buy') )

                  );
      },
    );


  }
}