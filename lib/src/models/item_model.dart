class Item {
  final String idItem;
  final String name;
  final double price;
  final int stock;

  Item({this.idItem, this.price, this.name,this.stock});

  Map<String, dynamic> toMap() {
    return {'productId': idItem, 'name': name, 'price': price};
  }

  /// Constructor con nombre que recibe la respuesta del Backernd(Firebase) y la mapea al modelo
  Item.fromFirestore(Map<String, dynamic> firestore)
      : idItem = firestore['id_item'],
        name = firestore['name'],
        price = firestore['price'],
        stock = firestore ['stock'];
}
