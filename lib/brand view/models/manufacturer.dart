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
  String logoImage;
  String email;
  List<Agreement> productions;
  Manufacturer({
    required this.name,
    required this.location,
    required this.notes,
    required this.id,
    required this.privateKey,
    required this.accountID,
    required this.logoImage,
    required this.email,
    required this.productions,
  });

  Manufacturer copyWith({
    String? name,
    String? location,
    String? notes,
    String? id,
    String? privateKey,
    String? accountID,
    String? logoImage,
    String? email,
    List<Agreement>? productions,
  }) {
    return Manufacturer(
      name: name ?? this.name,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      id: id ?? this.id,
      privateKey: privateKey ?? this.privateKey,
      accountID: accountID ?? this.accountID,
      logoImage: logoImage ?? this.logoImage,
      email: email ?? this.email,
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
      'logoImage': logoImage,
      'email': email,
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
      logoImage: map['logoImage'] ?? '',
      email: map['email'] ?? '',
      productions: List<Agreement>.from(
          map['productions']?.map((x) => Agreement.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Manufacturer(name: $name, location: $location, notes: $notes, id: $id, privateKey: $privateKey, accountID: $accountID, logoImage: $logoImage, email: $email, productions: $productions)';
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
        other.logoImage == logoImage &&
        other.email == email &&
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
        logoImage.hashCode ^
        email.hashCode ^
        productions.hashCode;
  }
}

class Agreement {
  String agreementID;
  Product product;
  Agreement({
    required this.agreementID,
    required this.product,
  });

  Agreement copyWith({
    String? agreementID,
    Product? product,
  }) {
    return Agreement(
      agreementID: agreementID ?? this.agreementID,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'agreementID': agreementID,
      'product': product.toMap(),
    };
  }

  factory Agreement.fromMap(Map<String, dynamic> map) {
    return Agreement(
      agreementID: map['agreementID'] ?? '',
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Agreement.fromJson(String source) =>
      Agreement.fromMap(json.decode(source));

  @override
  String toString() =>
      'Agreement(agreementID: $agreementID, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Agreement &&
        other.agreementID == agreementID &&
        other.product == product;
  }

  @override
  int get hashCode => agreementID.hashCode ^ product.hashCode;
}
