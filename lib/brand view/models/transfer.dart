import 'dart:convert';

class Transfer {
  String senderAddress;
  String receiverAddress;
  String receiptID;
  String brandID;
  String productID;
  Transfer({
    required this.senderAddress,
    required this.receiverAddress,
    required this.receiptID,
    required this.brandID,
    required this.productID,
  });

  Transfer copyWith({
    String? senderAddress,
    String? receiverAddress,
    String? receiptID,
    String? brandID,
    String? productID,
  }) {
    return Transfer(
      senderAddress: senderAddress ?? this.senderAddress,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      receiptID: receiptID ?? this.receiptID,
      brandID: brandID ?? this.brandID,
      productID: productID ?? this.productID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderAddress': senderAddress,
      'receiverAddress': receiverAddress,
      'receiptID': receiptID,
      'brandID': brandID,
      'productID': productID,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      senderAddress: map['senderAddress'] ?? '',
      receiverAddress: map['receiverAddress'] ?? '',
      receiptID: map['receiptID'] ?? '',
      brandID: map['brandID'] ?? '',
      productID: map['productID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transfer(senderAddress: $senderAddress, receiverAddress: $receiverAddress, receiptID: $receiptID, brandID: $brandID, productID: $productID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transfer &&
        other.senderAddress == senderAddress &&
        other.receiverAddress == receiverAddress &&
        other.receiptID == receiptID &&
        other.brandID == brandID &&
        other.productID == productID;
  }

  @override
  int get hashCode {
    return senderAddress.hashCode ^
        receiverAddress.hashCode ^
        receiptID.hashCode ^
        brandID.hashCode ^
        productID.hashCode;
  }
}
