class User {
  final bool isNew;
  final String? companyName;
  final String? clientId;
  final String? clientSecret;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.isNew,
    this.companyName,
    this.clientId,
    this.clientSecret,
    this.accessToken,
    this.refreshToken,
  });

  static const empty = User(isNew: true);

  User copyWith({
    bool? isNew,
    String? companyName,
    String? clientId,
    String? clientSecret,
    String? deviceCode,
    String? accessToken,
    String? refreshToken,
  }) {
    return User(
      isNew: isNew ?? this.isNew,
      companyName: companyName ?? this.companyName,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
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
    );
  }

  @override
  String toString() {
    return 'User(isNew: $isNew)';
  }
}
