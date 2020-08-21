class Item {
  final String productId;
  final String name;
  final double price;
  final int stock;

  Item({this.productId, this.price, this.name,this.stock});

  Map<String, dynamic> toMap() {
    return {'productId': productId, 'name': name, 'price': price};
  }

  /// Constructor con nombre que recibe la respuesta del Backernd(Firebase) y la mapea al modelo
  Item.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'],
        stock = firestore ['stock'];
}
