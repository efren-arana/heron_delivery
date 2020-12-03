/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heron_delivery/core/constants/routes_name.dart' as routes;
import 'package:heron_delivery/core/models/item_model.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/ui/views/order_detail_view.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

List<String> status = [
  'ACEPTADO',
  'CANCELADO',
  'PREPARADO',
  'ENVIADO',
  'RECHAZADA',
  'ENTREGADO',
];

class BuyView extends StatefulWidget {
  BuyView({Key key}) : super(key: key);

  @override
  _BuyViewState createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    pr = ProgressDialog(context);

    pr.style(message: 'Please wait...');
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(routes.RouteTabView);
                //createAlertDialog(context, cart);
              },
              child: Text('Pedir')),
        ),
      ),
    );
  }

  createAlertDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar')),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  pr.show();
                  addOrder(cart: cart, shopId: 'fn6npNA8Xm4TvuPKB2VE');
                },
                child: Text('Acepto')),
          ],
        );
      },
    );
  }

  ///Metod para registra la orden
  ///Registra la orden y recibe los siguientes parametros
  ///[shopId] : id de la tienda donde se registrara la orden
  ///[cart] : carrtio de compra con todos los item que se requieren vender
  Future<void> addOrder({String shopId, CartProvider cart}) {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    List<ItemModel> items = cart.basketItems;

    //configuracione de la app
    double iva = 0.0;
    double costDelivery = 0.50;

    //obtengo la referencia a la coleccion de ordenes (id)
    DocumentReference orderReference =
        FirebaseFirestore.instance.collection('shops/$shopId/orders').doc();
    //obtengo la referencia a la coleccion de facturas (id)
    DocumentReference invoiceReference =
        FirebaseFirestore.instance.collection('shops/$shopId/invoices').doc();
    //Obtengo la referencia de la tienda
    DocumentReference shopReference =
        FirebaseFirestore.instance.collection('shops').doc('/$shopId');

    //ejecuto la transaccion

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      //=================================================
      //(1) Validar el status de la tienda.
      //=================================================
      // Get the shop document
      DocumentSnapshot snapshotShop = await transaction.get(shopReference);
      //valido que existe la coleccion de shops
      if (!snapshotShop.exists) {
        throw Exception("La tienda no existe!!!");
      }
      //Valido el status este activo
      //caso contratio aborto la transaccion
      String status = snapshotShop.get('status');
      if (status.compareTo('A') != 0) {
        throw Exception("La tienda se encuentra INACTIVA");
      }
      //=================================================
      //(2) valido la disponibilidad de los items que se requieren
      //(3) valida que la cant de items seleccionados por item no supere el stock
      // actual de la base de datos
      //=================================================
      for (int i = 0; i < items.length; i++) {
        DocumentReference itemReference = FirebaseFirestore.instance
            .collection('shops/$shopId/items')
            .doc('/${items[i].itemId}');
        // Get the item document
        DocumentSnapshot snapshot = await transaction.get(itemReference);

        if (!snapshot.exists) {
          throw Exception("El item ${items[i].itemId} no existe en inventario");
        }
        //Valido que el status de item este activo (A)
        //caso contratio aborto la transaccion
        String status = snapshot.get('status');
        if (status.compareTo('A') != 0) {
          throw Exception("El item ${items[i].name} se encuentra inactivo");
        }
        //Valido la disponibilidad del producto
        // esta validacion la realizo previamente
        // para que cuando se valide la cantidad de items seleccionados
        // por item ya lanza la excepcion
        //previamente si el item se agoto y no esta disponible
        //una funcion dispara la actualizacion a available = false
        //caso contratio aborto la transaccion
        if (!snapshot.get('available')) {
          throw Exception(
              "El item ${items[i].name} no se encuentra disponible en este momento");
        }
        //valida que la cantidad de items seleccionados
        //no supere el stock de la base de datos
        if (items[i].cantSelected > snapshot.get('stock')) {
          throw Exception(
              'La cantidad de items seleccionados de ${items[i].name} supera el stock');
        }
      }
      //actualizo el stock de los productos seleccionados
      for (var item in items) {
        DocumentReference itemReference = FirebaseFirestore.instance
            .collection('shops/$shopId/items')
            .doc('/${item.itemId}');
        // Get the item document

        DocumentSnapshot snapshot = await transaction.get(itemReference);

        //actualizo el stock de los productos seleccionados
        int stock = snapshot.data()['stock'] - item.cantSelected;
        batch.update(itemReference, {'stock': stock});
      }
      //confirmo la actualizacion de los productos
      batch.commit();

      //Registro la orden
      transaction.set(orderReference, {
        'status': 'REGISTRADO',
        'order_id': orderReference.id,
        'delivery_address': {
          'main_street': 'bolivar',
          'secondary_street': 'Srg. Pavon',
          'city': 'Samborondon',
          'reference': 'frente la cisa',
        },
        'cant_items': cart.count,
        'deliverer_id': '01010100101010101',
        'deliverer_ref': 'users/document',
        'customer_id': 'uyouyoiuyoiuy',
        'customer_ref': 'users/document',
        'location_delivery': GeoPoint(-90, 90),
        'shop_ref': shopReference,
        'shop_id': shopReference.id,
        'location_shop': snapshotShop.get('location'),
        'dispatch_address': snapshotShop.get('shop_address'),
        'payment_type_id': '7890709790',
        'payment_type_ref': 'type_payment/document001',
        'cost_envio': costDelivery,
        'IVA': iva,
        'total': cart.subTotal + iva + costDelivery,
        'subtotal': cart.subTotal,
        'date_create_order': FieldValue.serverTimestamp(),
        'date_require_order': FieldValue.serverTimestamp(),
        'shipped_date': FieldValue.serverTimestamp(),
      });

      //Registro la factura
      transaction.set(invoiceReference, {
        'RUC': '',
        'cant_items': cart.count,
        'deliverer_id': '01010100101010101',
        'deliverer_ref': 'users/document',
        'customer_id': 'uyouyoiuyoiuy',
        'customer_ref': 'users/document',
        'invoice_id': invoiceReference.id,
        'num_invoice': '00000000000000',
        'payment_type_id': '7890709790',
        'payment_type_ref': 'type_payment/document001',
        'shop_ref': shopReference,
        'shop_id': shopReference.id,
        'IVA': iva,
        'tipo_pago_id': '7890709790',
        'tipo_pago_ref': 'type_payment/document001',
        'cost_envio': costDelivery,
        'subtotal': cart.subTotal,
        'total': cart.subTotal + iva + costDelivery,
        'date_create_invoice': FieldValue.serverTimestamp()
      });

      //Registrar los detalles de la orden
      items.forEach((element) {
        //obtengo la referencia del detalle de la orden (order_detail_id)
        DocumentReference orderDetailReference = FirebaseFirestore.instance
            .collection('shops/$shopId/order_invoice_details')
            .doc();
        //Obtengo la referencia del producto seleccionado
        DocumentReference itemReference = FirebaseFirestore.instance
            .collection('shops/$shopId/items')
            .doc('/${element.itemId}');

        //registro el detalle de la orden y la factura
        transaction.set(orderDetailReference, {
          'detail_id': orderDetailReference.id,
          'item_id': itemReference.id,
          'item_ref': itemReference,
          'order_id': orderReference.id,
          'order_ref': orderReference,
          'invoice_id': invoiceReference.id,
          'invoice_ref': invoiceReference,
          'quantity': element.cantSelected,
          'price_unit': element.unitPriceSale,
          'price_total': element.total,
        });
      });
    }).then((value) {
      pr.hide().whenComplete(() {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => OrderDetailView(
                  value: value,
                )));
      });
    }).catchError((error) {
      pr.hide().whenComplete(() {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => OrderDetailView(
                  value: error,
                  hasError: true,
                )));
      });
    });
  }
}
*/