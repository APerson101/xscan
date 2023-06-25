import 'dart:convert';

import 'package:flutter/foundation.dart';

// 0.0.23599

class ItemOwnershipHistory {
  String id;
  String barcode;
  String brandID;
  List<Owner> owners;
  ItemOwnershipHistory({
    required this.id,
    required this.barcode,
    required this.brandID,
    required this.owners,
  });

  ItemOwnershipHistory copyWith({
    String? id,
    String? barcode,
    String? productID,
    String? brandID,
    List<Owner>? owners,
  }) {
    return ItemOwnershipHistory(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      brandID: brandID ?? this.brandID,
      owners: owners ?? this.owners,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'brandID': brandID,
      'owners': owners.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemOwnershipHistory.fromMap(Map<String, dynamic> map) {
    return ItemOwnershipHistory(
      id: map['id'] ?? '',
      barcode: map['barcode'] ?? '',
      brandID: map['brandID'] ?? '',
      owners: List<Owner>.from(map['owners']?.map((x) => Owner.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOwnershipHistory.fromJson(String source) =>
      ItemOwnershipHistory.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemOwnershipHistory &&
        other.id == id &&
        other.barcode == barcode &&
        other.brandID == brandID &&
        listEquals(other.owners, owners);
  }

  @override
  int get hashCode {
    return id.hashCode ^ barcode.hashCode ^ brandID.hashCode ^ owners.hashCode;
  }

  @override
  String toString() {
    return 'ItemOwnershipHistory(id: $id, barcode: $barcode, brandID: $brandID, owners: $owners)';
  }
}

class Owner {
  String accountID;
  String amountPaid;
  DateTime purchased;
  Owner({
    required this.accountID,
    required this.amountPaid,
    required this.purchased,
  });

  Owner copyWith({
    String? accountID,
    String? amountPaid,
    DateTime? purchased,
  }) {
    return Owner(
      accountID: accountID ?? this.accountID,
      amountPaid: amountPaid ?? this.amountPaid,
      purchased: purchased ?? this.purchased,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountID': accountID,
      'amountPaid': amountPaid,
      'purchased': purchased.millisecondsSinceEpoch,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      accountID: map['accountID'] ?? '',
      amountPaid: map['amountPaid'] ?? '',
      purchased: DateTime.fromMillisecondsSinceEpoch(map['purchased']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Owner.fromJson(String source) => Owner.fromMap(json.decode(source));

  @override
  String toString() =>
      'Owner(accountID: $accountID, amountPaid: $amountPaid, purchased: $purchased)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Owner &&
        other.accountID == accountID &&
        other.amountPaid == amountPaid &&
        other.purchased == purchased;
  }

  @override
  int get hashCode =>
      accountID.hashCode ^ amountPaid.hashCode ^ purchased.hashCode;
}
