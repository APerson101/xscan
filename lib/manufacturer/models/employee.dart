import 'dart:convert';

class Employee {
  String email;
  String password;
  String name;
  String id;
  String businessID;
  String image;
  Employee({
    required this.email,
    required this.password,
    required this.name,
    required this.id,
    required this.businessID,
    required this.image,
  });

  Employee copyWith({
    String? email,
    String? password,
    String? name,
    String? id,
    String? businessID,
    String? image,
  }) {
    return Employee(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      id: id ?? this.id,
      businessID: businessID ?? this.businessID,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'id': id,
      'businessID': businessID,
      'image': image,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      businessID: map['businessID'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(email: $email, password: $password, name: $name, id: $id, businessID: $businessID, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.id == id &&
        other.businessID == businessID &&
        other.image == image;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        name.hashCode ^
        id.hashCode ^
        businessID.hashCode ^
        image.hashCode;
  }
}
