import 'dart:convert';

class CircleAmountObject {
  String amount;
  String currency;
  CircleAmountObject({
    required this.amount,
    required this.currency,
  });

  CircleAmountObject copyWith({
    String? amount,
    String? currency,
  }) {
    return CircleAmountObject(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  factory CircleAmountObject.fromMap(Map<String, dynamic> map) {
    return CircleAmountObject(
      amount: map['amount'] ?? '',
      currency: map['currency'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleAmountObject.fromJson(String source) =>
      CircleAmountObject.fromMap(json.decode(source));

  @override
  String toString() =>
      'CircleAmountObject(amount: $amount, currency: $currency)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CircleAmountObject &&
        other.amount == amount &&
        other.currency == currency;
  }

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;
}

class CircleDestinationObject {
  String type;
  String addressId;
  CircleDestinationObject({
    required this.type,
    required this.addressId,
  });

  CircleDestinationObject copyWith({
    String? type,
    String? addressId,
  }) {
    return CircleDestinationObject(
      type: type ?? this.type,
      addressId: addressId ?? this.addressId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'addressId': addressId,
    };
  }

  factory CircleDestinationObject.fromMap(Map<String, dynamic> map) {
    return CircleDestinationObject(
      type: map['type'] ?? '',
      addressId: map['addressId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleDestinationObject.fromJson(String source) =>
      CircleDestinationObject.fromMap(json.decode(source));

  @override
  String toString() =>
      'CircleDestinationObject(type: $type, addressId: $addressId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CircleDestinationObject &&
        other.type == type &&
        other.addressId == addressId;
  }

  @override
  int get hashCode => type.hashCode ^ addressId.hashCode;
}
