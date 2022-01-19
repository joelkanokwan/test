import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String message;
  final String status;
  final Timestamp timeNoti;
  final String token;
  final String uidCustomer;
  NotificationModel({
    required this.title,
    required this.message,
    required this.status,
    required this.timeNoti,
    required this.token,
    required this.uidCustomer,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'status': status,
      'timeNoti': timeNoti,
      'token': token,
      'uidCustomer': uidCustomer,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      timeNoti: map['timeNoti'],
      token: map['token'] ?? '',
      uidCustomer: map['uidCustomer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));
}
