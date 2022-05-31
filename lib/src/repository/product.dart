import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class ProductRepository {
  final String _userId;
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({required String userId})
      : _firebaseFirestore = FirebaseFirestore.instance,
        _userId = userId;

  static _productCollectionPath({required String userId}) =>
      'user/$userId/offers';

  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(_productCollectionPath(userId: _userId))
          .get();

      final docs = snapshot.docs.map((doc) => doc.data());

      final list = docs.map((data) => Product.fromMap(data)).toList();
      return list;
    } catch (e) {
      log('Error => ProductRepository -> getProducts {${e.toString()}}');
    }
    return [];
  }

  Future<void> updateProduct({required Product product}) async {
    await _firebaseFirestore
        .collection(_productCollectionPath(userId: _userId))
        .doc(product.id)
        .set(product.toMap());
  }
}
