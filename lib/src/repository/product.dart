import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../cache/cache.dart';

import '../models/models.dart';

class ProductRepository {
  final String _userId;
  final FirebaseFirestore _firebaseFirestore;
  final Cache _cache;

  ProductRepository({required String userId})
      : _firebaseFirestore = FirebaseFirestore.instance,
        _cache = Cache(),
        _userId = userId;

  static _productCollectionPath({required String userId}) =>
      'user/$userId/offers';

  static const productsListKey = '___products_list_key___';

  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(_productCollectionPath(userId: _userId))
          .get();
      final docs = snapshot.docs.map((doc) => doc.data());
      final list = docs.map((data) => Product.fromMap(data)).toList();

      _cache.write(key: productsListKey, value: list);

      return list;
    } catch (e) {
      log('Error => ProductRepository -> getProducts {${e.toString()}}');
      return [];
    }
  }

  Future<List<Product>> get products async =>
      _cache.read<List<Product>>(key: productsListKey) ?? await getProducts();

  Future<void> updateProductInDatabase({required Product product}) async {
    await _firebaseFirestore
        .collection(_productCollectionPath(userId: _userId))
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> updateProduct({required Product product}) async {
    try {
      await updateProductInDatabase(product: product);

      final list = await products;
      list[list.indexWhere((element) => element.id == product.id)] = product;
      _cache.write(key: productsListKey, value: list);
    } catch (e) {
      log('Error => ProductRepository -> updateProduct {${e.toString()}}');
    }
  }
}
