

import 'package:cloud_firestore/cloud_firestore.dart';

class JoinFiretoreService {
  final Firestore _fireStore = Firestore.instance;    

getWishList(wishlistId) async {
  return await _fireStore.collection('wishlists').document(wishlistId).get();
}

getProduct(productId) async {
  return await _fireStore.collection('product').document(productId).get();
}
/*
Future<List<Product>>getProductsWishList(wishlistId) async {

  var _wishlists = null;
  List<Product> _products = []; // I am assuming that you have product model like above

  await getWishList(wishlistId).then((val) {
    _wishlists = Wishlist.fromMap(val.data);

    _wishlists.forEach((wish) {
      await getProduct(wish.productId).then((product) {
          _products.add(product));
      });
    });
  });

  return _products;

}
*/
}