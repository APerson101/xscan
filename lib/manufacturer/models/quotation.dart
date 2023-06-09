import 'dart:convert';

import 'package:xscan/brand%20view/models/brand_manufacturer.dart';

import '../../brand view/models/manufacturer.dart';

class QuotationModel {
  int amount;
  String brandID;
  String id;
  Manufacturer manu;
  BrandManufaturer transaction;
  bool brandAgreed;
  QuotationModel({
    required this.amount,
    required this.brandID,
    required this.id,
    required this.manu,
    required this.transaction,
    required this.brandAgreed,
  });

  QuotationModel copyWith({
    int? amount,
    String? brandID,
    String? id,
    Manufacturer? manu,
    BrandManufaturer? transaction,
    bool? brandAgreed,
  }) {
    return QuotationModel(
      amount: amount ?? this.amount,
      brandID: brandID ?? this.brandID,
      id: id ?? this.id,
      manu: manu ?? this.manu,
      transaction: transaction ?? this.transaction,
      brandAgreed: brandAgreed ?? this.brandAgreed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'brandID': brandID,
      'id': id,
      'manu': manu.toMap(),
      'transaction': transaction.toMap(),
      'brandAgreed': brandAgreed,
    };
  }

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      amount: map['amount']?.toInt() ?? 0,
      brandID: map['brandID'] ?? '',
      id: map['id'] ?? '',
      manu: Manufacturer.fromMap(map['manu']),
      transaction: BrandManufaturer.fromMap(map['transaction']),
      brandAgreed: map['brandAgreed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuotationModel.fromJson(String source) =>
      QuotationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuotationModel(amount: $amount, brandID: $brandID, id: $id, manu: $manu, transaction: $transaction, brandAgreed: $brandAgreed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuotationModel &&
        other.amount == amount &&
        other.brandID == brandID &&
        other.id == id &&
        other.manu == manu &&
        other.transaction == transaction &&
        other.brandAgreed == brandAgreed;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        brandID.hashCode ^
        id.hashCode ^
        manu.hashCode ^
        transaction.hashCode ^
        brandAgreed.hashCode;
  }
}
