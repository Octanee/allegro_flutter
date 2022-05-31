import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final bool isNew;
  final String? companyName;
  final String? clientId;
  final String? clientSecret;
  final String? accessToken;
  final String? refreshToken;
  final DateTime? refreshTokenDate;

  const User({
    required this.isNew,
    this.companyName,
    this.clientId,
    this.clientSecret,
    this.accessToken,
    this.refreshToken,
    this.refreshTokenDate,
  });

  static const empty = User(isNew: true);

  static DateTime calculatetRefreshTokenDate({required int expiresIn}) {
    final refreshTokenDate =
        DateTime.now().add(Duration(seconds: (expiresIn * 0.9).toInt()));
    return refreshTokenDate;
  }

  bool get needToRefresh => refreshTokenDate?.isBefore(DateTime.now()) ?? true;

  User copyWith({
    bool? isNew,
    String? companyName,
    String? clientId,
    String? clientSecret,
    String? deviceCode,
    String? accessToken,
    String? refreshToken,
    DateTime? refreshTokenDate,
  }) {
    return User(
      isNew: isNew ?? this.isNew,
      companyName: companyName ?? this.companyName,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenDate: refreshTokenDate ?? this.refreshTokenDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isNew': isNew,
      'companyName': companyName,
      'clientId': clientId,
      'clientSecret': clientSecret,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'refreshTokenDate': refreshTokenDate != null
          ? Timestamp.fromDate(refreshTokenDate!)
          : null,
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      isNew: map?['isNew'] ?? true,
      companyName: map?['companyName'],
      clientId: map?['clientId'],
      clientSecret: map?['clientSecret'],
      accessToken: map?['accessToken'],
      refreshToken: map?['refreshToken'],
      refreshTokenDate: (map?['refreshTokenDate'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return 'User(isNew: $isNew)';
  }

  String toFullString() {
    return 'User(isNew: $isNew, companyName: $companyName, clientId: $clientId, clientSecret: $clientSecret, accessToken: $accessToken, refreshToken: $refreshToken, refreshTokenDate: $refreshTokenDate)';
  }
}
