import 'dart:convert';

class FileModelHedera {
  String productName;
  String manufacturerName;
  String manufacturerApproved;
  String brandApproved;
  DateTime created;
  String brandName;
  String productID;
  String barcode;
  FileModelHedera({
    required this.productName,
    required this.manufacturerName,
    required this.manufacturerApproved,
    required this.brandApproved,
    required this.created,
    required this.brandName,
    required this.productID,
    required this.barcode,
  });

  FileModelHedera copyWith({
    String? productName,
    String? manufacturerName,
    String? manufacturerApproved,
    String? brandApproved,
    DateTime? created,
    String? brandName,
    String? productID,
    String? barcode,
  }) {
    return FileModelHedera(
      productName: productName ?? this.productName,
      manufacturerName: manufacturerName ?? this.manufacturerName,
      manufacturerApproved: manufacturerApproved ?? this.manufacturerApproved,
      brandApproved: brandApproved ?? this.brandApproved,
      created: created ?? this.created,
      brandName: brandName ?? this.brandName,
      productID: productID ?? this.productID,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'manufacturerName': manufacturerName,
      'manufacturerApproved': manufacturerApproved,
      'brandApproved': brandApproved,
      'created': created.millisecondsSinceEpoch,
      'brandName': brandName,
      'productID': productID,
      'barcode': barcode,
    };
  }

  factory FileModelHedera.fromMap(Map<String, dynamic> map) {
    return FileModelHedera(
      productName: map['productName'] ?? '',
      manufacturerName: map['manufacturerName'] ?? '',
      manufacturerApproved: map['manufacturerApproved'] ?? '',
      brandApproved: map['brandApproved'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      brandName: map['brandName'] ?? '',
      productID: map['productID'] ?? '',
      barcode: map['barcode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModelHedera.fromJson(String source) =>
      FileModelHedera.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FileModelHedera(productName: $productName, manufacturerName: $manufacturerName, manufacturerApproved: $manufacturerApproved, brandApproved: $brandApproved, created: $created, brandName: $brandName, productID: $productID, barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileModelHedera &&
        other.productName == productName &&
        other.manufacturerName == manufacturerName &&
        other.manufacturerApproved == manufacturerApproved &&
        other.brandApproved == brandApproved &&
        other.created == created &&
        other.brandName == brandName &&
        other.productID == productID &&
        other.barcode == barcode;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        manufacturerName.hashCode ^
        manufacturerApproved.hashCode ^
        brandApproved.hashCode ^
        created.hashCode ^
        brandName.hashCode ^
        productID.hashCode ^
        barcode.hashCode;
  }
}
