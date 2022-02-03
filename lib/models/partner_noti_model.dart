import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:joelfindtechnician/models/appointment_model.dart';

class PartnerNotiModel {
  final String title;
  final Timestamp timestamp;
  final bool bolCollection;
  final String status;
  final String docId;
  final AppointmentModel? appointmentModel;
  PartnerNotiModel({
    required this.title,
    required this.timestamp,
    required this.bolCollection,
    required this.status,
    required this.docId,
    this.appointmentModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'timestamp': timestamp,
      'bolCollection': bolCollection,
      'status': status,
      'docId': docId,
      'appointmentModel': appointmentModel?.toMap(),
    };
  }

  factory PartnerNotiModel.fromMap(Map<String, dynamic> map) {
    return PartnerNotiModel(
      title: map['title'] ?? '',
      timestamp: (map['timestamp']),
      bolCollection: map['bolCollection'] ?? false,
      status: map['status'] ?? '',
      docId: map['docId'] ?? '',
      appointmentModel: map['appointmentModel'] != null
          ? AppointmentModel.fromMap(map['appointmentModel'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerNotiModel.fromJson(String source) =>
      PartnerNotiModel.fromMap(json.decode(source));
}
