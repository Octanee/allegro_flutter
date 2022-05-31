import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'allegro_models.dart';

class AllegroOrder {
  final String id;
  final DateTime occurredAt;
  final String type;
  final List<OrderItem> items;

  AllegroOrder({
    required this.id,
    required this.occurredAt,
    required this.type,
    required this.items,
  });

  int get numberOfItem {
    final value = items.fold<int>(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );
    return value;
  }

  AllegroOrder copyWith({
    String? id,
    DateTime? occurredAt,
    String? type,
    List<OrderItem>? items,
  }) {
    return AllegroOrder(
      id: id ?? this.id,
      occurredAt: occurredAt ?? this.occurredAt,
      type: type ?? this.type,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'occurredAt': Timestamp.fromDate(occurredAt),
      'type': type,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory AllegroOrder.fromMap(Map<String, dynamic> map) {
    return AllegroOrder(
      id: map['id'] ?? '',
      occurredAt: DateTime.parse(map['occurredAt']),
      type: map['type'] ?? '',
      items: List<OrderItem>.from(
        map['order']['lineItems']?.map((x) => OrderItem.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllegroOrder.fromJson(String source) =>
      AllegroOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllegroOrder(id: $id, occurredAt: $occurredAt, type: $type, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllegroOrder &&
        other.id == id &&
        other.occurredAt == occurredAt &&
        other.type == type &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^ occurredAt.hashCode ^ type.hashCode ^ items.hashCode;
  }
}
