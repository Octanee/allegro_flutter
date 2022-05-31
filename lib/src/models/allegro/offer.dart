import 'dart:convert';

class AllegroOffer {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final int available;
  final String primaryImage;

  AllegroOffer({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.available,
    required this.primaryImage,
  });

  AllegroOffer copyWith({
    String? id,
    String? name,
    String? categoryId,
    double? price,
    int? available,
    String? primaryImage,
  }) {
    return AllegroOffer(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      available: available ?? this.available,
      primaryImage: primaryImage ?? this.primaryImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'price': price,
      'available': available,
      'primaryImage': primaryImage,
    };
  }

  Map<String, dynamic> toAllegro() {
    return {
      'name': name,
      'category': {
        'id': categoryId,
      },
      'sellingMode': {
        'format': 'BUY_NOW',
        'price': {'amount': price.toString(), 'currency': 'PLN'}
      },
      'stock': {
        'available': available,
      }
    };
  }

  factory AllegroOffer.fromMap(Map<String, dynamic> map) {
    return AllegroOffer(
      id: map['id'],
      name: map['name'],
      categoryId: map['category']['id'],
      price: double.parse(map['sellingMode']['price']['amount']),
      available: map['stock']['available']?.toInt(),
      primaryImage: map['primaryImage']['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AllegroOffer.fromJson(String source) =>
      AllegroOffer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllegroOffer(id: $id, name: $name, categoryId: $categoryId, price: $price, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllegroOffer &&
        other.id == id &&
        other.name == name &&
        other.categoryId == categoryId &&
        other.price == price &&
        other.available == available &&
        other.primaryImage == primaryImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        categoryId.hashCode ^
        price.hashCode ^
        available.hashCode ^
        primaryImage.hashCode;
  }
}
