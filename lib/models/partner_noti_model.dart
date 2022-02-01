import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PartnerNotiModel {
  final String title;
  final Timestamp timestamp;
  final bool bolCollection;
  final String status;
  PartnerNotiModel({
    required this.title,
    required this.timestamp,
    required this.bolCollection,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'timestamp': timestamp,
      'bolCollection': bolCollection,
      'status': status,
    };
  }

  factory PartnerNotiModel.fromMap(Map<String, dynamic> map) {
    return PartnerNotiModel(
      title: map['title'] ?? '',
      timestamp: (map['timestamp']),
      bolCollection: map['bolCollection'] ?? false,
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerNotiModel.fromJson(String source) =>
      PartnerNotiModel.fromMap(json.decode(source));
}
