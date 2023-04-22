import 'dart:convert';

class BrandManufaturer {
  String brandID;
  String manufacturerID;
  String productID;
  int quantity;
  bool userCreated;
  bool manufacturerAgreed;
  DateTime dateCreated;
  String id;
  BrandManufaturer({
    required this.brandID,
    required this.manufacturerID,
    required this.productID,
    required this.quantity,
    required this.userCreated,
    required this.manufacturerAgreed,
    required this.dateCreated,
    required this.id,
  });

  BrandManufaturer copyWith({
    String? brandID,
    String? manufacturerID,
    String? productID,
    int? quantity,
    bool? userCreated,
    bool? manufacturerAgreed,
    DateTime? dateCreated,
    String? id,
  }) {
    return BrandManufaturer(
      brandID: brandID ?? this.brandID,
      manufacturerID: manufacturerID ?? this.manufacturerID,
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
      userCreated: userCreated ?? this.userCreated,
      manufacturerAgreed: manufacturerAgreed ?? this.manufacturerAgreed,
      dateCreated: dateCreated ?? this.dateCreated,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brandID': brandID,
      'manufacturerID': manufacturerID,
      'productID': productID,
      'quantity': quantity,
      'userCreated': userCreated,
      'manufacturerAgreed': manufacturerAgreed,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory BrandManufaturer.fromMap(Map<String, dynamic> map) {
    return BrandManufaturer(
      brandID: map['brandID'] ?? '',
      manufacturerID: map['manufacturerID'] ?? '',
      productID: map['productID'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      userCreated: map['userCreated'] ?? false,
      manufacturerAgreed: map['manufacturerAgreed'] ?? false,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandManufaturer.fromJson(String source) =>
      BrandManufaturer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BrandManufaturer(brandID: $brandID, manufacturerID: $manufacturerID, productID: $productID, quantity: $quantity, userCreated: $userCreated, manufacturerAgreed: $manufacturerAgreed, dateCreated: $dateCreated, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandManufaturer &&
        other.brandID == brandID &&
        other.manufacturerID == manufacturerID &&
        other.productID == productID &&
        other.quantity == quantity &&
        other.userCreated == userCreated &&
        other.manufacturerAgreed == manufacturerAgreed &&
        other.dateCreated == dateCreated &&
        other.id == id;
  }

  @override
  int get hashCode {
    return brandID.hashCode ^
        manufacturerID.hashCode ^
        productID.hashCode ^
        quantity.hashCode ^
        userCreated.hashCode ^
        manufacturerAgreed.hashCode ^
        dateCreated.hashCode ^
        id.hashCode;
  }
}
