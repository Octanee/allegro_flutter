import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'allegro_models.dart';

class AllegroOrder {
  final String id;
  final DateTime occurredAt;
  final AllegroOrderType type;
  final List<AllegroOrderItem> items;

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
    AllegroOrderType? type,
    List<AllegroOrderItem>? items,
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
      'type': type.name,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory AllegroOrder.fromMap(Map<String, dynamic> map) {
    return AllegroOrder(
      id: map['id'] ?? '',
      occurredAt: DateTime.parse(map['occurredAt']),
      type: AllegroOrderType.values.firstWhere(
        (element) => element.name == map['sellingMode']['format'],
      ),
      items: List<AllegroOrderItem>.from(
        map['order']['lineItems']?.map((x) => AllegroOrderItem.fromMap(x)),
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

enum AllegroOrderType {
  bought,
  filledIn,
  readyForProcessing,
  buyerCancelled,
  fulFillmentStatusChanged,
  autoCancelled;

  @override
  String toString() {
    switch (this) {
      case AllegroOrderType.bought:
        return 'BOUGHT';
      case AllegroOrderType.filledIn:
        return 'FILLED_IN';
      case AllegroOrderType.readyForProcessing:
        return 'READY_FOR_PROCESSING';
      case AllegroOrderType.buyerCancelled:
        return 'BUYER_CANCELLED';
      case AllegroOrderType.fulFillmentStatusChanged:
        return 'FULFILLMENT_STATUS_CHANGED';
      case AllegroOrderType.autoCancelled:
        return 'AUTO_CANCELLED';
    }
  }
}
