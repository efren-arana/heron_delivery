// Create a reference to the document the transaction will use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heron_delivery/src/models/item_model.dart';

class OrderTransaction {

  //Recibo en el constructor la lista de productos seleccionados
  List<Item> items = [];

  //envio en el constructor la referencia de la tienda
  DocumentReference shopReference = FirebaseFirestore.instance
      .collection('shops')
      .doc('/fn6npNA8Xm4TvuPKB2VE');

  //obtengo la referencia a la coleccion de ordenes

  Future<void> addOrder() {
    DocumentReference orderReference = FirebaseFirestore.instance
        .collection('shops/fn6npNA8Xm4TvuPKB2VE/orders')
        .doc();
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the shop document
          DocumentSnapshot snapshot = await transaction.get(shopReference);
          //valido que existe la coleccion
          if (!snapshot.exists) {
            throw Exception("La tienda no existe");
          }
          //Valido el status este activo
          //caso contratio aborto la transaccion
          String status = snapshot.get('status');
          if (status.compareTo('A') != 0) {
            throw Exception("La tienda se encuentra inactiva");
          }

          //valido la disponibilidad de los items que se requieren
          items.forEach((element) async{
            DocumentReference itemReference = FirebaseFirestore.instance
                .collection('shops/fn6npNA8Xm4TvuPKB2VE/items')
                .doc('/${element.productId}');
                // Get the item document
              DocumentSnapshot snapshot = await transaction.get(itemReference);
              if (!snapshot.exists) {
                throw Exception("El item no existe");
              }
              //Valido el status este activo
              //caso contratio aborto la transaccion
              String status = snapshot.get('status');
              if (status.compareTo('A') != 0) {
                throw Exception("El item se encuentra inactivo");
              }
          });

          // Update the follower count based on the current count
          double newFollowerCount = snapshot.data()['vote_average'] + 1;

          // Perform an update on the document
          transaction.update(shopReference, {'vote_average': newFollowerCount});

          //DocumentSnapshot orderSnapshop = await
          transaction.set(orderReference, {
            'status': 'Aceptado',
            'order_id': orderReference.id
          }).get(orderReference);

          // Return the new count
          return newFollowerCount;
        })
        .then((value) => print("Follower count updated to $value"))
        .catchError(
            (error) => print("Failed to update user followers: $error"));
  }
}
