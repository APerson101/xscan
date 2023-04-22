import 'dart:convert';

class ManufacturerSummary {
  String manufacturerName;
  String numberItemsProduced;
  String manufacturerLocation;
  String manufacturedProducts;
  ManufacturerSummary({
    required this.manufacturerName,
    required this.numberItemsProduced,
    required this.manufacturerLocation,
    required this.manufacturedProducts,
  });

  ManufacturerSummary copyWith({
    String? manufacturerName,
    String? numberItemsProduced,
    String? manufacturerLocation,
    String? manufacturedProducts,
  }) {
    return ManufacturerSummary(
      manufacturerName: manufacturerName ?? this.manufacturerName,
      numberItemsProduced: numberItemsProduced ?? this.numberItemsProduced,
      manufacturerLocation: manufacturerLocation ?? this.manufacturerLocation,
      manufacturedProducts: manufacturedProducts ?? this.manufacturedProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'manufacturerName': manufacturerName,
      'numberItemsProduced': numberItemsProduced,
      'manufacturerLocation': manufacturerLocation,
      'manufacturedProducts': manufacturedProducts,
    };
  }

  factory ManufacturerSummary.fromMap(Map<String, dynamic> map) {
    return ManufacturerSummary(
      manufacturerName: map['manufacturerName'] ?? '',
      numberItemsProduced: map['numberItemsProduced'] ?? '',
      manufacturerLocation: map['manufacturerLocation'] ?? '',
      manufacturedProducts: map['manufacturedProducts'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerSummary.fromJson(String source) =>
      ManufacturerSummary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManufacturerSummary(manufacturerName: $manufacturerName, numberItemsProduced: $numberItemsProduced, manufacturerLocation: $manufacturerLocation, manufacturedProducts: $manufacturedProducts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManufacturerSummary &&
        other.manufacturerName == manufacturerName &&
        other.numberItemsProduced == numberItemsProduced &&
        other.manufacturerLocation == manufacturerLocation &&
        other.manufacturedProducts == manufacturedProducts;
  }

  @override
  int get hashCode {
    return manufacturerName.hashCode ^
        numberItemsProduced.hashCode ^
        manufacturerLocation.hashCode ^
        manufacturedProducts.hashCode;
  }
}
