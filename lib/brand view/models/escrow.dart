import 'dart:convert';

class Escrow {
  EscrowStatusEnum status;
  String senderAccountID;
  String receiverAccountID;
  int amount;
  DateTime created;
  String id;
  Escrow(
      {required this.senderAccountID,
      required this.receiverAccountID,
      required this.amount,
      required this.created,
      required this.id,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'senderAccountID': senderAccountID,
      'receiverAccountID': receiverAccountID,
      'amount': amount,
      'id': id,
      'created': created.millisecondsSinceEpoch,
      'status': status.value
    };
  }

  factory Escrow.fromMap(Map<String, dynamic> map) {
    return Escrow(
        senderAccountID: map['senderAccountID'] ?? '',
        receiverAccountID: map['receiverAccountID'] ?? '',
        amount: map['amount']?.toInt() ?? 0,
        id: map['id'],
        created: DateTime.fromMillisecondsSinceEpoch(map['created']),
        status: EscrowStatusEnum.values
            .firstWhere((element) => element.value == map['status']));
  }

  String toJson() => json.encode(toMap());

  factory Escrow.fromJson(String source) => Escrow.fromMap(json.decode(source));
}

enum EscrowStatusEnum {
  pending(value: 'pending'),
  approved(value: 'approved'),
  rejected(value: 'rejected');

  final String value;
  const EscrowStatusEnum({required this.value});
}
