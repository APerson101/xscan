import 'dart:convert';

class UserModel {
  String name;
  String privateKey;
  String accountID;
  String email;
  String id;
  DateTime created;
  String profilePic;
  UserModel({
    required this.name,
    required this.privateKey,
    required this.accountID,
    required this.email,
    required this.id,
    required this.created,
    required this.profilePic,
  });

  UserModel copyWith({
    String? name,
    String? privateKey,
    String? accountID,
    String? email,
    String? id,
    DateTime? created,
    String? profilePic,
  }) {
    return UserModel(
      name: name ?? this.name,
      privateKey: privateKey ?? this.privateKey,
      accountID: accountID ?? this.accountID,
      email: email ?? this.email,
      id: id ?? this.id,
      created: created ?? this.created,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'privateKey': privateKey,
      'accountID': accountID,
      'email': email,
      'id': id,
      'created': created.millisecondsSinceEpoch,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      privateKey: map['privateKey'] ?? '',
      accountID: map['accountID'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      profilePic: map['profilePic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, privateKey: $privateKey, accountID: $accountID, email: $email, id: $id, created: $created, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.privateKey == privateKey &&
      other.accountID == accountID &&
      other.email == email &&
      other.id == id &&
      other.created == created &&
      other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      privateKey.hashCode ^
      accountID.hashCode ^
      email.hashCode ^
      id.hashCode ^
      created.hashCode ^
      profilePic.hashCode;
  }
}
