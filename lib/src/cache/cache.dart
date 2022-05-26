class Cache {
  final Map<String, Object> _cache;

  static final Cache _instance = Cache._();

  factory Cache() => _instance;

  Cache._() : _cache = <String, Object>{};

  static const userIdKey = '___user_id_key___';
  static const userKey = '___user_key___';
  static const accessTokenKey = '___access_token_key___';
  static const refreshTokenKey = '___refresh_token_key___';
  static const clientIdKey = '___client_id_key___';
  static const clientSecretKey = '___client_secret_key___';
  static const deviceCodeKey = '___device_code_key___';

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
