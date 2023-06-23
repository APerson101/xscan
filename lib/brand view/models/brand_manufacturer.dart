import 'dart:convert';

import 'package:xscan/brand%20view/models/product.dart';

class BrandManufaturer {
  String brandID;
  String manufacturerID;
  String productID;
  Product product;
  int quantity;
  bool userCreated;
  bool manufacturerAgreed;
  DateTime dateCreated;
  String id;
  int approved;
  BrandManufaturer({
    required this.brandID,
    required this.manufacturerID,
    required this.productID,
    required this.product,
    required this.quantity,
    required this.userCreated,
    required this.manufacturerAgreed,
    required this.dateCreated,
    required this.id,
    required this.approved,
  });

  BrandManufaturer copyWith({
    String? brandID,
    String? manufacturerID,
    String? productID,
    Product? product,
    int? quantity,
    bool? userCreated,
    bool? manufacturerAgreed,
    DateTime? dateCreated,
    String? id,
    int? approved,
  }) {
    return BrandManufaturer(
      brandID: brandID ?? this.brandID,
      manufacturerID: manufacturerID ?? this.manufacturerID,
      productID: productID ?? this.productID,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      userCreated: userCreated ?? this.userCreated,
      manufacturerAgreed: manufacturerAgreed ?? this.manufacturerAgreed,
      dateCreated: dateCreated ?? this.dateCreated,
      id: id ?? this.id,
      approved: approved ?? this.approved,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brandID': brandID,
      'manufacturerID': manufacturerID,
      'productID': productID,
      'product': product.toMap(),
      'quantity': quantity,
      'userCreated': userCreated,
      'manufacturerAgreed': manufacturerAgreed,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'id': id,
      'approved': approved,
    };
  }

  factory BrandManufaturer.fromMap(Map<String, dynamic> map) {
    return BrandManufaturer(
      brandID: map['brandID'] ?? '',
      manufacturerID: map['manufacturerID'] ?? '',
      productID: map['productID'] ?? '',
      product: Product.fromMap(map['product']),
      quantity: map['quantity']?.toInt() ?? 0,
      userCreated: map['userCreated'] ?? false,
      manufacturerAgreed: map['manufacturerAgreed'] ?? false,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      id: map['id'] ?? '',
      approved: map['approved']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandManufaturer.fromJson(String source) =>
      BrandManufaturer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BrandManufaturer(brandID: $brandID, manufacturerID: $manufacturerID, productID: $productID, product: $product, quantity: $quantity, userCreated: $userCreated, manufacturerAgreed: $manufacturerAgreed, dateCreated: $dateCreated, id: $id, approved: $approved)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandManufaturer &&
        other.brandID == brandID &&
        other.manufacturerID == manufacturerID &&
        other.productID == productID &&
        other.product == product &&
        other.quantity == quantity &&
        other.userCreated == userCreated &&
        other.manufacturerAgreed == manufacturerAgreed &&
        other.dateCreated == dateCreated &&
        other.id == id &&
        other.approved == approved;
  }

  @override
  int get hashCode {
    return brandID.hashCode ^
        manufacturerID.hashCode ^
        productID.hashCode ^
        product.hashCode ^
        quantity.hashCode ^
        userCreated.hashCode ^
        manufacturerAgreed.hashCode ^
        dateCreated.hashCode ^
        id.hashCode ^
        approved.hashCode;
  }
}
