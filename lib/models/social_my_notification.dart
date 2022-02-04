import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SocialMyNotificationModel {
  final String docIdPostCustomer;
  final String docIdTechnic;
  final Timestamp timeConfirm;
  final bool readed;
  SocialMyNotificationModel({
    required this.docIdPostCustomer,
    required this.docIdTechnic,
    required this.timeConfirm,
    required this.readed,
  });

  Map<String, dynamic> toMap() {
    return {
      'docIdPostCustomer': docIdPostCustomer,
      'docIdTechnic': docIdTechnic,
      'timeConfirm': timeConfirm,
      'readed': readed,
    };
  }

  factory SocialMyNotificationModel.fromMap(Map<String, dynamic> map) {
    return SocialMyNotificationModel(
      docIdPostCustomer: map['docIdPostCustomer'] ?? '',
      docIdTechnic: map['docIdTechnic'] ?? '',
      timeConfirm: (map['timeConfirm']),
      readed: map['readed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMyNotificationModel.fromJson(String source) =>
      SocialMyNotificationModel.fromMap(json.decode(source));
}
