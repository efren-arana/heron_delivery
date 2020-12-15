import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/core/viewmodels/home_view_model.dart';
import 'package:heron_delivery/ui/views/home_view.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.trash),
                    onPressed: () => cart.removeAll())
              ],
              title: Text('Checkout Page [\$ ${cart.subTotal}]'),
            ),
            body: cart.basketItems.length == 0
                ? Text('no items in your cart')
                : ListView.builder(
                    itemCount: cart.basketItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Text(
                              '\$' + cart.basketItems[index].total.toString()),
                          title: Row(
                            children: [
                              Text(cart.basketItems[index].item.name),
                              Container(
                                  color: Colors.amber,
                                  child: Row(children: [
                                    IconButton(
                                        icon: FaIcon(Icons.remove),
                                        onPressed: () =>
                                            cart.decreaseQuantityOfItem(
                                                cart.basketItems[index])),
                                    Text(
                                        '${cart.basketItems[index].cantSelected}'),
                                    IconButton(
                                      icon: FaIcon(Icons.add),
                                      onPressed: () => cart.increaseCantOfItems(
                                          cart.basketItems[index]),
                                    )
                                  ])),
                            ],
                          ),
                          subtitle: Text(cart
                                  .basketItems[index].item.unitPriceSale
                                  .toString() +
                              ' X${cart.basketItems[index].cantSelected}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              cart.removeItemFromList(cart.basketItems[index]);
                            },
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => homeViewModel.navigateToMakeOrdertView()));
      },
    );
  }
}
