import 'dart:convert';

import 'package:flutter/foundation.dart';

class Review {
  String id;
  String text;
  int stars;
  String productID;
  ReviewTypeEnum reviewType;
  Review(
      {required this.id,
      required this.text,
      required this.stars,
      required this.productID,
      required this.reviewType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'stars': stars,
      'productID': productID,
      'reviewType': describeEnum(reviewType)
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      reviewType: ReviewTypeEnum.values
          .firstWhere((element) => describeEnum(element) == map['reviewType']),
      stars: map['stars'] ?? '',
      productID: map['productID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(id: $id, text: $text, stars: $stars, productID: $productID)';
  }
}

enum ReviewTypeEnum { original, sell }
