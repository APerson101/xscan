import 'dart:convert';

class TransferModel {
  String from;
  String to;
  TransferModel({
    required this.from,
    required this.to,
  });

  TransferModel copyWith({
    String? from,
    String? to,
  }) {
    return TransferModel(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
    };
  }

  factory TransferModel.fromMap(Map<String, dynamic> map) {
    return TransferModel(
      from: map['from'] ?? '',
      to: map['to'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferModel.fromJson(String source) =>
      TransferModel.fromMap(json.decode(source));

  @override
  String toString() => 'TransferModel(from: $from, to: $to)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransferModel && other.from == from && other.to == to;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
