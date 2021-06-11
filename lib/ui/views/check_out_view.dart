import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/core/viewmodels/home_view_model.dart';

import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Checkout'),
              actions: <Widget>[
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.trash),
                    onPressed: () => cart.removeAll())
              ],
            ),
            body: cart.basketItems.length == 0
                ? Center(child: Text('No hay items en su carrito!'))
                : ListView.builder(
                    itemCount: cart.basketItems.length,
                    itemBuilder: (context, index) {
                      return _CardSection(index);
                      /*
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
                      */
                    },
                  ),
            bottomNavigationBar: _BottomAppBarSection());
      },
    );
  }
}

class _CardSection extends StatelessWidget {
  final int index;
  const _CardSection(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Text(cart.basketItems[index].item.name),
                  Spacer(),
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.times, size: 17),
                      onPressed: () =>
                          cart.removeItemFromList(cart.basketItems[index]))
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text('Precio'),
                  Spacer(flex: 2),
                  Text('\$' + '${cart.basketItems[index].item.unitPriceSale}'),
                  Spacer(flex: 3),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text('Cantidad'),
                  Spacer(),
                  Container(
                      child: Row(children: [
                    IconButton(
                        icon: FaIcon(Icons.remove),
                        onPressed: () => cart
                            .decreaseQuantityOfItem(cart.basketItems[index])),
                    Text('X' + '${cart.basketItems[index].cantSelected}'),
                    IconButton(
                      icon: FaIcon(Icons.add),
                      onPressed: () =>
                          cart.increaseCantOfItems(cart.basketItems[index]),
                    )
                  ])),
                  Spacer(),
                  Text('\$' + cart.basketItems[index].total.toString())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomAppBarSection extends StatelessWidget {
  const _BottomAppBarSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    return Consumer<CartProvider>(
      builder: (context, model, child) => BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            padding:
                EdgeInsets.only(top: 5.0, bottom: 2.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Subtotal'),
                      Spacer(),
                      Text('\$' + model.subTotal.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Costo de envío'),
                      Spacer(),
                      Text('\$' + '${model.costDelivery.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total'),
                      Spacer(),
                      Text('\$' + '${model.granTotal}'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                          //color: (model.itemsInBasket)
                          //    ? theme.getColorBlueHex
                          //    : Color.fromRGBO(99, 101, 105, 0.4),
                          onPressed: () {
                            if (model.itemsInBasket) {
                              homeViewModel.navigateToMakeOrdertView();
                            }
                          },
                          child: Text('Continuar',
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
