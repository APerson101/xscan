import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:xscan/brand%20view/models/product.dart';

class Brand {
  String name;
  String id;
  String location;
  DateTime created;
  List<Product> catalog;
  Brand({
    required this.name,
    required this.id,
    required this.location,
    required this.created,
    required this.catalog,
  });

  Brand copyWith({
    String? name,
    String? id,
    String? location,
    DateTime? created,
    List<Product>? catalog,
  }) {
    return Brand(
      name: name ?? this.name,
      id: id ?? this.id,
      location: location ?? this.location,
      created: created ?? this.created,
      catalog: catalog ?? this.catalog,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'location': location,
      'created': created.millisecondsSinceEpoch,
      'catalog': catalog.map((x) => x.toMap()).toList(),
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      location: map['location'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      catalog:
          List<Product>.from(map['catalog']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Brand(name: $name, id: $id, location: $location, created: $created, catalog: $catalog)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Brand &&
        other.name == name &&
        other.id == id &&
        other.location == location &&
        other.created == created &&
        listEquals(other.catalog, catalog);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        location.hashCode ^
        created.hashCode ^
        catalog.hashCode;
  }
}