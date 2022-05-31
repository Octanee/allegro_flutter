import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final bool isNew;
  final String? clientId;
  final String? clientSecret;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.isNew,
    this.clientId,
    this.clientSecret,
    this.accessToken,
    this.refreshToken,
  });

  static const empty = User(isNew: true);

  User copyWith({
    bool? isNew,
    String? clientId,
    String? clientSecret,
    String? deviceCode,
    String? accessToken,
    String? refreshToken,
    DateTime? refreshTokenDate,
  }) {
    return User(
      isNew: isNew ?? this.isNew,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isNew': isNew,
      'clientId': clientId,
      'clientSecret': clientSecret,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      isNew: map?['isNew'] ?? true,
      clientId: map?['clientId'],
      clientSecret: map?['clientSecret'],
      accessToken: map?['accessToken'],
      refreshToken: map?['refreshToken'],
    );
  }

  @override
  String toString() {
    return 'User(isNew: $isNew)';
  }

  String toFullString() {
    return 'User(isNew: $isNew, clientId: $clientId, clientSecret: $clientSecret, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
