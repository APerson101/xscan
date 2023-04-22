import 'dart:convert';

class SalesModel {
  String name;
  String email;
  String brandID;
  String id;
  String brandName;
  String privateKey;
  String accountID;
  SalesModel({
    required this.name,
    required this.email,
    required this.brandID,
    required this.id,
    required this.brandName,
    required this.privateKey,
    required this.accountID,
  });

  SalesModel copyWith({
    String? name,
    String? email,
    String? brandID,
    String? id,
    String? brandName,
    String? privateKey,
    String? accountID,
  }) {
    return SalesModel(
      name: name ?? this.name,
      email: email ?? this.email,
      brandID: brandID ?? this.brandID,
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      privateKey: privateKey ?? this.privateKey,
      accountID: accountID ?? this.accountID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'brandID': brandID,
      'id': id,
      'brandName': brandName,
      'privateKey': privateKey,
      'accountID': accountID,
    };
  }

  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      brandID: map['brandID'] ?? '',
      id: map['id'] ?? '',
      brandName: map['brandName'] ?? '',
      privateKey: map['privateKey'] ?? '',
      accountID: map['accountID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesModel.fromJson(String source) =>
      SalesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesModel(name: $name, email: $email, brandID: $brandID, id: $id, brandName: $brandName, privateKey: $privateKey, accountID: $accountID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalesModel &&
        other.name == name &&
        other.email == email &&
        other.brandID == brandID &&
        other.id == id &&
        other.brandName == brandName &&
        other.privateKey == privateKey &&
        other.accountID == accountID;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        brandID.hashCode ^
        id.hashCode ^
        brandName.hashCode ^
        privateKey.hashCode ^
        accountID.hashCode;
  }
}
