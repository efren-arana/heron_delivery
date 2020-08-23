// Create a reference to the document the transaction will use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/src/models/item_detail_model.dart';
import 'package:heron_delivery/src/providers/cart_provider.dart';

/// Metodo que registra la orden
Future<DocumentSnapshot> addOrder({String shopId, Cart cart}) {
  WriteBatch batch = FirebaseFirestore.instance.batch();

  List<LineItem> items = cart.basketItems;
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
    DocumentSnapshot snapshot = await transaction.get(shopReference);
    //valido que existe la coleccion de shops
    if (!snapshot.exists) {
      throw Exception("La tienda no existe!!!");
    }
    //Valido el status este activo
    //caso contratio aborto la transaccion
    String status = snapshot.get('status');
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
          .doc('/${items[i].idItem}');
      // Get the item document
      DocumentSnapshot snapshot = await transaction.get(itemReference);

      if (!snapshot.exists) {
        throw Exception("El item no existe");
      }
      //Valido que el status de item este activo (A)
      //caso contratio aborto la transaccion
      String status = snapshot.get('status');
      if (status.compareTo('A') != 0) {
        throw Exception("El item se encuentra inactivo");
      }
      //valida que la cantidad de items seleccionados
      //no supere el stock de la base de datos
      if (items[i].cantSelected > snapshot.get('stock')) {
        throw Exception(
            'La cantidad de items seleccionados de ${items[i].itemName} supera el stock');
      }
    }

    for (var item in items) {
      DocumentReference itemReference = FirebaseFirestore.instance
          .collection('shops/$shopId/items')
          .doc('/${item.idItem}');
      // Get the item document

      DocumentSnapshot snapshot = await transaction.get(itemReference);

      //actualizo el stock de los productos seleccionados
      int stock = snapshot.data()['stock'] - item.cantSelected;
      print('item: ${item.itemName}');
      print('stock actual: ${snapshot.data()['stock']}');
      print('stock selected: ${item.cantSelected}');
      print('diferencia: $stock');
      batch.update(itemReference, {'stock': stock});
    }
    //confirmo la actualizacion de los productos
    batch.commit();

    //Registro la orden
    transaction.set(orderReference, {
      'status': 'Aceptado',
      'order_id': orderReference.id,
      'tiemstamp': FieldValue.serverTimestamp()
    });

    //Registro la factura
    transaction.set(invoiceReference, {
      'order_id': orderReference,
      'invoice_id': invoiceReference.id,
      'shop_id': shopReference,
      'subtotal': cart.subTotal,
      'IVA': iva,
      'cost_envio': costDelivery,
      'total': cart.subTotal + iva + costDelivery,
      'createInvoice': FieldValue.serverTimestamp()
    });

    //Registrar los detalles de la orden
    items.forEach((element) {
      //obtengo la referencia del detalle de la orden (order_detail_id)
      DocumentReference orderDetailReference = FirebaseFirestore.instance
          .collection('shops/$shopId/orders/${orderReference.id}/order_details')
          .doc();
      //Obtengo la referencia del producto seleccionado
      DocumentReference itemReference = FirebaseFirestore.instance
          .collection('shops/$shopId/items')
          .doc('/${element.idItem}');

      //registro el detalle de la orden
      transaction.set(orderDetailReference, {
        'order_detail_id': orderDetailReference.id,
        'item_id': itemReference
      });
    });

    //retorno la orden registrada
    return orderReference.get();
  });
  //.then((value) => print("Order registered to $value"))
  //.catchError((error) => print("Failed to register order: $error"));
}
