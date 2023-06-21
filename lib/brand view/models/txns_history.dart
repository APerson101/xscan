import 'dart:convert';

import 'package:xscan/brand%20view/models/circle_destination.dart';

// 0.0.23599

class CircleTransferObject {
  String transactionHash;
  String status;
  String id;
  String destinationAddress;
  String destinationChain;
  String senderAddress;
  String senderChain;
  CircleAmountObject amount;
  CircleTransferObject({
    required this.transactionHash,
    required this.status,
    required this.id,
    required this.senderAddress,
    required this.senderChain,
    required this.destinationAddress,
    required this.destinationChain,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionHash': transactionHash,
      'status': status,
      'id': id,
      'destinationAddress': destinationAddress,
      'destinationChain': destinationChain,
      'senderAddress': senderAddress,
      'senderChain': senderChain,
      'amount': amount.toMap(),
    };
  }

  factory CircleTransferObject.fromMap(Map<String, dynamic> map) {
    return CircleTransferObject(
      transactionHash: map['transactionHash'] ?? '',
      status: map['status'] ?? '',
      id: map['id'] ?? '',
      destinationAddress: map['destinationAddress'] ?? '',
      destinationChain: map['destinationChain'] ?? '',
      senderAddress: map['senderAddress'] ?? '',
      senderChain: map['senderChain'] ?? '',
      amount: CircleAmountObject.fromMap(map['amount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleTransferObject.fromJson(String source) =>
      CircleTransferObject.fromMap(json.decode(source));
}
