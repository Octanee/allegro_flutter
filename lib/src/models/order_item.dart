import 'dart:convert';

class OrderItem {
  final String productId;
  final String productImage;
  final String productName;
  final int quantity;
  final int maxQuantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.quantity,
    required this.maxQuantity,
    required this.price,
  });

  OrderItem copyWith({
    String? productId,
    String? productImage,
    String? productName,
    int? quantity,
    int? maxQuantity,
    double? price,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      productImage: productImage ?? this.productImage,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productImage': productImage,
      'productName': productName,
      'quantity': quantity,
      'maxQuantity': maxQuantity,
      'price': price,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      productImage: map['productImage'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      maxQuantity: map['maxQuantity']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(productId: $productId, productImage: $productImage, productName: $productName, quantity: $quantity, maxQuantity: $maxQuantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderItem &&
      other.productId == productId &&
      other.productImage == productImage &&
      other.productName == productName &&
      other.quantity == quantity &&
      other.maxQuantity == maxQuantity &&
      other.price == price;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      productImage.hashCode ^
      productName.hashCode ^
      quantity.hashCode ^
      maxQuantity.hashCode ^
      price.hashCode;
  }
}
