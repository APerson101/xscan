import 'dart:convert';

import 'package:flutter/foundation.dart';

class CircleBalances {
  List<Balance>? available;
  List<Balance>? unsettled;
  CircleBalances({
    this.available,
    this.unsettled,
  });

  CircleBalances copyWith({
    List<Balance>? available,
    List<Balance>? unsettled,
  }) {
    return CircleBalances(
      available: available ?? this.available,
      unsettled: unsettled ?? this.unsettled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'available': available?.map((x) => x.toMap()).toList() ?? [],
      'unsettled': unsettled?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory CircleBalances.fromMap(Map<String, dynamic> map) {
    return CircleBalances(
      available: List<Balance>.from(
          map['available']?.map((x) => Balance.fromMap(x)) ??
              const Iterable.empty()),
      unsettled: List<Balance>.from(
          map['unsettled']?.map((x) => Balance.fromMap(x)) ??
              const Iterable.empty()),
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleBalances.fromJson(String source) =>
      CircleBalances.fromMap(json.decode(source));

  @override
  String toString() =>
      'CircleBalances(available: $available, unsettled: $unsettled)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CircleBalances &&
        listEquals(other.available, available) &&
        listEquals(other.unsettled, unsettled);
  }

  @override
  int get hashCode => available.hashCode ^ unsettled.hashCode;
}

class Balance {
  String? amount;
  String? currency;
  Balance({
    this.amount,
    this.currency,
  });

  Balance copyWith({
    String? amount,
    String? currency,
  }) {
    return Balance(
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

  factory Balance.fromMap(Map<String, dynamic> map) {
    return Balance(
      amount: map['amount'] ?? '',
      currency: map['currency'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Balance.fromJson(String source) =>
      Balance.fromMap(json.decode(source));

  @override
  String toString() => 'Balance(amount: $amount, currency: $currency)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Balance &&
        other.amount == amount &&
        other.currency == currency;
  }

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;
}
