import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:xscan/brand%20view/models/product.dart';

class Manufacturer {
  String name;
  String location;
  String notes;
  String id;
  String privateKey;
  String accountID;
  List<Product> productions;
  Manufacturer({
    required this.name,
    required this.location,
    required this.notes,
    required this.id,
    required this.privateKey,
    required this.accountID,
    required this.productions,
  });

  Manufacturer copyWith({
    String? name,
    String? location,
    String? notes,
    String? id,
    String? privateKey,
    String? accountID,
    List<Product>? productions,
  }) {
    return Manufacturer(
      name: name ?? this.name,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      id: id ?? this.id,
      privateKey: privateKey ?? this.privateKey,
      accountID: accountID ?? this.accountID,
      productions: productions ?? this.productions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'notes': notes,
      'id': id,
      'privateKey': privateKey,
      'accountID': accountID,
      'productions': productions.map((x) => x.toMap()).toList(),
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      notes: map['notes'] ?? '',
      id: map['id'] ?? '',
      privateKey: map['privateKey'] ?? '',
      accountID: map['accountID'] ?? '',
      productions: List<Product>.from(
          map['productions']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Manufacturer(name: $name, location: $location, notes: $notes, id: $id, privateKey: $privateKey, accountID: $accountID, productions: $productions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Manufacturer &&
        other.name == name &&
        other.location == location &&
        other.notes == notes &&
        other.id == id &&
        other.privateKey == privateKey &&
        other.accountID == accountID &&
        listEquals(other.productions, productions);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        location.hashCode ^
        notes.hashCode ^
        id.hashCode ^
        privateKey.hashCode ^
        accountID.hashCode ^
        productions.hashCode;
  }
}
