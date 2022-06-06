import 'package:cloud_firestore/cloud_firestore.dart';

import '../cache/cache.dart';
import '../models/models.dart';

class UserRepository {
  final String _userId;
  final Cache _cache;
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({required String userId})
      : _userId = userId,
        _cache = Cache(),
        _firebaseFirestore = FirebaseFirestore.instance;

  static const _userCollectionPath = 'user';
  static const userKey = '___user_key___';

  Stream<User> get user {
    return _firebaseFirestore
        .collection(_userCollectionPath)
        .doc(_userId)
        .snapshots()
        .map((snap) {
      final user = User.fromMap(snap.data());
      _cache.write(key: userKey, value: user);
      return user;
    });
  }

  User get currentUser => _cache.read<User>(key: userKey) ?? User.empty;

  Future<void> createUser({required User user}) async {
    return _firebaseFirestore
        .collection(_userCollectionPath)
        .doc(_userId)
        .set(user.toMap());
  }

  Future<void> updateUser({required User user}) async {
    return _firebaseFirestore
        .collection(_userCollectionPath)
        .doc(_userId)
        .update(user.toMap());
  }
}
