import 'dart:convert';

class Product {
  final String id;
  final String allegroId;
  final String name;
  final double? purchasePrice;
  final double allegroPrice;
  final String imageUrl;
  final int quantity;
  final bool isActive;

  Product({
    required this.id,
    required this.allegroId,
    required this.name,
    required this.allegroPrice,
    required this.quantity,
    required this.imageUrl,
    required this.isActive,
    this.purchasePrice,
  });

  Product copyWith({
    String? id,
    String? allegroId,
    String? name,
    double? purchasePrice,
    double? allegroPrice,
    String? imageUrl,
    int? quantity,
    bool? isActive,
  }) {
    return Product(
      id: id ?? this.id,
      allegroId: allegroId ?? this.allegroId,
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      allegroPrice: allegroPrice ?? this.allegroPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toAllegro() {
    return {
      'sellingMode': {
        'price': {
          'amount': allegroPrice.toString(),
        }
      },
      'stock': {
        'available': quantity,
      }
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'allegroId': allegroId,
      'name': name,
      'purchasePrice': purchasePrice,
      'allegroPrice': allegroPrice,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      allegroId: map['allegroId'],
      isActive: map['isActive'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      purchasePrice: map['purchasePrice']?.toDouble(),
      allegroPrice: map['allegroPrice'].toDouble(),
      quantity: map['quantity'].toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, allegroId: $allegroId, isActive: $isActive,+ name: $name, purchasePrice: $purchasePrice, allegroPrice: $allegroPrice, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.allegroId == allegroId &&
        other.isActive == isActive &&
        other.name == name &&
        other.purchasePrice == purchasePrice &&
        other.allegroPrice == allegroPrice &&
        other.imageUrl == imageUrl &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        allegroId.hashCode ^
        isActive.hashCode ^
        name.hashCode ^
        purchasePrice.hashCode ^
        allegroPrice.hashCode ^
        imageUrl.hashCode ^
        quantity.hashCode;
  }
}
