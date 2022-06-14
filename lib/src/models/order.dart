import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'models.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final DateTime occurredAt;
  final DateTime lastUpdate;
  final OrderDeliverer deliverer;
  final OrderStatus status;
  final OrderPlatform platform;
  final double price;
  final Customer? customer;

  Order({
    required this.id,
    required this.items,
    required this.occurredAt,
    required this.lastUpdate,
    required this.deliverer,
    required this.status,
    required this.platform,
    this.price = 0,
    this.customer,
  });

  Order copyWith({
    String? id,
    List<OrderItem>? items,
    DateTime? occurredAt,
    DateTime? lastUpdate,
    OrderDeliverer? deliverer,
    OrderStatus? status,
    OrderPlatform? platform,
    Customer? customer,
    double? price,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      occurredAt: occurredAt ?? this.occurredAt,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      deliverer: deliverer ?? this.deliverer,
      status: status ?? this.status,
      platform: platform ?? this.platform,
      customer: customer ?? this.customer,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((x) => x.toMap()).toList(),
      'occurredAt': occurredAt.millisecondsSinceEpoch,
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
      'deliverer': deliverer.toString(),
      'status': status.toString(),
      'platform': platform.toString(),
      'customer': customer?.toMap(),
      'price': price,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      items:
          List<OrderItem>.from(map['items']?.map((x) => OrderItem.fromMap(x))),
      occurredAt: DateTime.fromMillisecondsSinceEpoch(map['occurredAt']),
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(map['lastUpdate']),
      deliverer: OrderDeliverer.fromString(map['deliverer']),
      status: OrderStatus.fromString(map['status']),
      platform: OrderPlatform.fromString(map['platform']),
      customer: Customer.fromMap(map['customer']),
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, items: $items, price: $price, occurredAt: $occurredAt, lastUpdate: $lastUpdate, deliverer: $deliverer, status: $status, platform: $platform, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        listEquals(other.items, items) &&
        other.occurredAt == occurredAt &&
        other.lastUpdate == lastUpdate &&
        other.deliverer == deliverer &&
        other.platform == platform &&
        other.customer == customer &&
        other.price == price &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        items.hashCode ^
        price.hashCode ^
        occurredAt.hashCode ^
        lastUpdate.hashCode ^
        deliverer.hashCode ^
        platform.hashCode ^
        customer.hashCode ^
        status.hashCode;
  }
}

enum OrderPlatform {
  allegro,
  instagram,
  facebook;

  @override
  String toString() {
    switch (this) {
      case OrderPlatform.allegro:
        return 'Allegro';
      case OrderPlatform.instagram:
        return 'Instagram';
      case OrderPlatform.facebook:
        return 'Facebook';
    }
  }

  factory OrderPlatform.fromString(String value) {
    switch (value) {
      case 'Instagram':
        return OrderPlatform.instagram;
      case 'Facebook':
        return OrderPlatform.facebook;
      case 'Allegro':
      default:
        return OrderPlatform.allegro;
    }
  }
}

enum OrderDeliverer {
  inpost(price: 16.5),
  inpostLocker(price: 14.5);

  final double price;
  const OrderDeliverer({required this.price});

  @override
  String toString() {
    switch (this) {
      case OrderDeliverer.inpost:
        return 'Inpost';
      case OrderDeliverer.inpostLocker:
        return 'Inpost Locker';
    }
  }

  factory OrderDeliverer.fromString(String value) {
    switch (value) {
      case 'Inpost':
        return OrderDeliverer.inpost;
      case 'Inpost Locker':
      default:
        return OrderDeliverer.inpostLocker;
    }
  }
}

enum OrderStatus {
  waitning,
  paid,
  packed,
  sent,
  delivered,
  cancelled;

  @override
  String toString() {
    switch (this) {
      case OrderStatus.waitning:
        return 'Waiting';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.sent:
        return 'Sent';
      case OrderStatus.packed:
        return 'Packed';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.paid:
        return 'Paid';
    }
  }

  factory OrderStatus.fromString(String value) {
    switch (value) {
      case 'Cancelled':
        return OrderStatus.cancelled;
      case 'Sent':
        return OrderStatus.sent;
      case 'Packed':
        return OrderStatus.packed;
      case 'Delivered':
        return OrderStatus.delivered;
      case 'Paid':
        return OrderStatus.paid;
      case 'Waiting':
      default:
        return OrderStatus.waitning;
    }
  }
}
