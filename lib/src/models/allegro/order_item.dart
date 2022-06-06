import 'dart:convert';

class AllegroOrderItem {
  final String id;
  final String offerId;
  final String name;
  final int quantity;
  final double price;
  
  AllegroOrderItem({
    required this.id,
    required this.offerId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  AllegroOrderItem copyWith({
    String? id,
    String? offerId,
    String? name,
    int? quantity,
    double? price,
  }) {
    return AllegroOrderItem(
      id: id ?? this.id,
      offerId: offerId ?? this.offerId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'offerId': offerId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory AllegroOrderItem.fromMap(Map<String, dynamic> map) {
    return AllegroOrderItem(
      id: map['id'],
      offerId: map['offer']['id'],
      name: map['offer']['name'] ,
      quantity: map['quantity']?.toInt(),
      price: double.parse(map['price']['amount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllegroOrderItem.fromJson(String source) =>
      AllegroOrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(id: $id, offerId: $offerId, name: $name, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllegroOrderItem &&
        other.id == id &&
        other.offerId == offerId &&
        other.name == name &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        offerId.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        price.hashCode;
  }
}
