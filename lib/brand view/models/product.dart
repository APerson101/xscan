import 'dart:convert';

class Product {
  String name;
  String id;
  String brandOwner;
  String notes;
  String? imageLink;
  DateTime created;
  Product({
    required this.name,
    required this.id,
    required this.brandOwner,
    required this.notes,
    this.imageLink,
    required this.created,
  });

  Product copyWith({
    String? name,
    String? id,
    String? brandOwner,
    String? notes,
    String? imageLink,
    DateTime? created,
  }) {
    return Product(
      name: name ?? this.name,
      id: id ?? this.id,
      brandOwner: brandOwner ?? this.brandOwner,
      notes: notes ?? this.notes,
      imageLink: imageLink ?? this.imageLink,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'brandOwner': brandOwner,
      'notes': notes,
      'imageLink': imageLink,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      brandOwner: map['brandOwner'] ?? '',
      notes: map['notes'] ?? '',
      imageLink: map['imageLink'],
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, id: $id, brandOwner: $brandOwner, notes: $notes, imageLink: $imageLink, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.id == id &&
        other.brandOwner == brandOwner &&
        other.notes == notes &&
        other.imageLink == imageLink &&
        other.created == created;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        brandOwner.hashCode ^
        notes.hashCode ^
        imageLink.hashCode ^
        created.hashCode;
  }
}
