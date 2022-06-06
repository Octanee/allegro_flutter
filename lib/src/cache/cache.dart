import 'dart:developer';

class Cache {
  final Map<String, Object> _cache;

  static final Cache _instance = Cache._();

  factory Cache() => _instance;

  Cache._() : _cache = <String, Object>{};

  void write<T extends Object>({required String key, required T value}) {
    log('Cache -> write {key: $key, type: $T}');
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) {
      log('Cache -> read {key: $key, type: $T}');
      return value;
    }
    log('Cache -> read {Null on key: $key}');
    return null;
  }
}
