import 'dart:convert';

class SalesModel {
  String name;
  String email;
  String brandID;
  String id;
  String password;
  String brandName;
  String image;
  String privateKey;
  String accountID;
  SalesModel({
    required this.name,
    required this.email,
    required this.brandID,
    required this.id,
    required this.password,
    required this.brandName,
    required this.image,
    required this.privateKey,
    required this.accountID,
  });

  SalesModel copyWith({
    String? name,
    String? email,
    String? brandID,
    String? id,
    String? password,
    String? brandName,
    String? image,
    String? privateKey,
    String? accountID,
  }) {
    return SalesModel(
      name: name ?? this.name,
      email: email ?? this.email,
      brandID: brandID ?? this.brandID,
      id: id ?? this.id,
      password: password ?? this.password,
      brandName: brandName ?? this.brandName,
      image: image ?? this.image,
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
      'password': password,
      'brandName': brandName,
      'image': image,
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
      password: map['password'] ?? '',
      brandName: map['brandName'] ?? '',
      image: map['image'] ?? '',
      privateKey: map['privateKey'] ?? '',
      accountID: map['accountID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesModel.fromJson(String source) =>
      SalesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesModel(name: $name, email: $email, brandID: $brandID, id: $id, password: $password, brandName: $brandName, image: $image, privateKey: $privateKey, accountID: $accountID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalesModel &&
        other.name == name &&
        other.email == email &&
        other.brandID == brandID &&
        other.id == id &&
        other.password == password &&
        other.brandName == brandName &&
        other.image == image &&
        other.privateKey == privateKey &&
        other.accountID == accountID;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        brandID.hashCode ^
        id.hashCode ^
        password.hashCode ^
        brandName.hashCode ^
        image.hashCode ^
        privateKey.hashCode ^
        accountID.hashCode;
  }
}
