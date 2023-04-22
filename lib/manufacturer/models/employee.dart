import 'dart:convert';

class Employee {
  String email;
  String password;
  String name;
  String id;
  String businessID;
  Employee({
    required this.email,
    required this.password,
    required this.name,
    required this.id,
    required this.businessID,
  });

  Employee copyWith({
    String? email,
    String? password,
    String? name,
    String? id,
    String? businessID,
  }) {
    return Employee(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      id: id ?? this.id,
      businessID: businessID ?? this.businessID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'id': id,
      'businessID': businessID,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      businessID: map['businessID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(email: $email, password: $password, name: $name, id: $id, businessID: $businessID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.id == id &&
        other.businessID == businessID;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        name.hashCode ^
        id.hashCode ^
        businessID.hashCode;
  }
}
