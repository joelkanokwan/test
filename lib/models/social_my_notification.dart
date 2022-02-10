import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return <String, dynamic>{
      'docIdPostCustomer': docIdPostCustomer,
      'docIdTechnic': docIdTechnic,
      'timeConfirm': timeConfirm,
      'readed': readed,
    };
  }

  factory SocialMyNotificationModel.fromMap(Map<String, dynamic> map) {
    return SocialMyNotificationModel(
      docIdPostCustomer: (map['docIdPostCustomer'] ?? '') as String,
      docIdTechnic: (map['docIdTechnic'] ?? '') as String,
      timeConfirm: (map['timeConfirm']),
      readed: (map['readed'] ?? false) as bool,
    );
  }

  factory SocialMyNotificationModel.fromJson(String source) =>
      SocialMyNotificationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
