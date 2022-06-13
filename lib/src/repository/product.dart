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

  Future<List<Product>> _getProducts() async {
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
      _cache.read<List<Product>>(key: productsListKey) ?? await _getProducts();

  Future<void> _updateProductInDatabase({required Product product}) async {
    await _firebaseFirestore
        .collection(_productCollectionPath(userId: _userId))
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> updateProduct({required Product product}) async {
    try {
      await _updateProductInDatabase(product: product);

      final list = await products;

      final id = list.indexWhere((element) => element.id == product.id);

      if (id == -1) {
        list.add(product);
      } else {
        list[id] = product;
      }

      _cache.write(key: productsListKey, value: list);
    } catch (e) {
      log('Error => ProductRepository -> updateProduct {${e.toString()}}');
    }
  }

  Future<Product> getProductOfId({required String id}) async {
    final list = await products;
    final product = list.firstWhere((element) => element.id == id);
    return product;
  }

  Future<int> getProductQuantity({required String id}) async {
    final product = await getProductOfId(id: id);
    return product.quantity;
  }

  Future<void> updateProductQuantity({
    required String id,
    required int quantity,
    bool isActive = true,
  }) async {
    try {
      final product = await getProductOfId(id: id);
      final newProduct =
          product.copyWith(quantity: quantity, isActive: isActive);
      await updateProduct(product: newProduct);
    } catch (e) {
      log('Error => ProductRepository -> updateProductQuantity {${e.toString()}}');
    }
  }
}
