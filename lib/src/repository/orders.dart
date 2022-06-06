import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../cache/cache.dart';
import '../models/models.dart';

class OrdersRepository {
  final String _userId;
  final FirebaseFirestore _firebaseFirestore;
  final Cache _cache;

  OrdersRepository({required String userId})
      : _firebaseFirestore = FirebaseFirestore.instance,
        _cache = Cache(),
        _userId = userId;

  static _ordersCollectionPath({required String userId}) =>
      'user/$userId/orders';

  static const ordersListKey = '___orders_list_key___';

  Future<List<Order>> getOrders() async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(_ordersCollectionPath(userId: _userId))
          .get();

      final docs = snapshot.docs.map((doc) => doc.data());
      final list = docs.map((data) => Order.fromMap(data)).toList();

      _cache.write(key: ordersListKey, value: list);

      return list;
    } catch (e) {
      log('Error => OrdersRepository -> getOrders {${e.toString()}}');
      return [];
    }
  }

  Future<List<Order>> get orders async =>
      _cache.read<List<Order>>(key: ordersListKey) ?? await getOrders();
}
