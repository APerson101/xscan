import 'dart:convert';

class Verification {
  String brandID;
  String productID;
  DateTime dateRequested;
  Verification({
    required this.brandID,
    required this.productID,
    required this.dateRequested,
  });

  Verification copyWith({
    String? brandID,
    String? productID,
    DateTime? dateRequested,
  }) {
    return Verification(
      brandID: brandID ?? this.brandID,
      productID: productID ?? this.productID,
      dateRequested: dateRequested ?? this.dateRequested,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brandID': brandID,
      'productID': productID,
      'dateRequested': dateRequested.millisecondsSinceEpoch,
    };
  }

  factory Verification.fromMap(Map<String, dynamic> map) {
    return Verification(
      brandID: map['brandID'] ?? '',
      productID: map['productID'] ?? '',
      dateRequested: DateTime.fromMillisecondsSinceEpoch(map['dateRequested']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Verification.fromJson(String source) =>
      Verification.fromMap(json.decode(source));

  @override
  String toString() =>
      'Verification(brandID: $brandID, productID: $productID, dateRequested: $dateRequested)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Verification &&
        other.brandID == brandID &&
        other.productID == productID &&
        other.dateRequested == dateRequested;
  }

  @override
  int get hashCode =>
      brandID.hashCode ^ productID.hashCode ^ dateRequested.hashCode;
}
