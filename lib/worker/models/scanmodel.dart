import 'dart:convert';

import 'package:xscan/manufacturer/models/employee.dart';

class ScanModel {
  String? id;
  String? barcode;
  String? addrressID;
  String? productID;
  String? productName;
  DateTime? timeAdded;
  String? brandName;
  Employee? scanner;
  ScanModel({
    this.id,
    this.barcode,
    this.addrressID,
    this.productID,
    this.productName,
    this.timeAdded,
    this.brandName,
    this.scanner,
  });

  ScanModel copyWith({
    String? id,
    String? barcode,
    String? addrressID,
    String? productID,
    String? productName,
    DateTime? timeAdded,
    String? brandName,
    Employee? scanner,
  }) {
    return ScanModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      addrressID: addrressID ?? this.addrressID,
      productID: productID ?? this.productID,
      productName: productName ?? this.productName,
      timeAdded: timeAdded ?? this.timeAdded,
      brandName: brandName ?? this.brandName,
      scanner: scanner ?? this.scanner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'addrressID': addrressID,
      'productID': productID,
      'productName': productName,
      'timeAdded': timeAdded?.millisecondsSinceEpoch,
      'brandName': brandName,
      'scanner': scanner?.toMap(),
    };
  }

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      id: map['id'] ?? '',
      barcode: map['barcode'],
      addrressID: map['addrressID'],
      productID: map['productID'],
      productName: map['productName'],
      timeAdded: map['timeAdded'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeAdded'])
          : null,
      brandName: map['brandName'],
      scanner: map['scanner'] != null ? Employee.fromMap(map['scanner']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanModel.fromJson(String source) =>
      ScanModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScanModel(id: $id, barcode: $barcode, addrressID: $addrressID, productID: $productID, productName: $productName, timeAdded: $timeAdded, brandName: $brandName, scanner: $scanner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScanModel &&
        other.id == id &&
        other.barcode == barcode &&
        other.addrressID == addrressID &&
        other.productID == productID &&
        other.productName == productName &&
        other.timeAdded == timeAdded &&
        other.brandName == brandName &&
        other.scanner == scanner;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        barcode.hashCode ^
        addrressID.hashCode ^
        productID.hashCode ^
        productName.hashCode ^
        timeAdded.hashCode ^
        brandName.hashCode ^
        scanner.hashCode;
  }
}
