import 'package:firebase_auth/firebase_auth.dart';

import '../cache/cache.dart';
import '../exceptions/exceptions.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final Cache _cache;

  AuthenticationRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _cache = Cache();

  static const userIdKey = '___user_id_key___';

  Stream<String> get userId {
    return _firebaseAuth.authStateChanges().map((user) {
      final userId = user?.uid ?? '';
      _cache.write(key: userIdKey, value: userId);
      return userId;
    });
  }

  String get currentUserId => _cache.read<String>(key: userIdKey) ?? '';

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpException.fromCode(e.code);
    } catch (_) {
      throw const SignUpException();
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInException.fromCode(e.code);
    } catch (_) {
      throw const LogInException();
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw LogOutException.fromCode(e.code);
    } catch (_) {
      throw const LogOutException();
    }
  }
}
