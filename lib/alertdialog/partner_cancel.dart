import 'package:flutter/material.dart';

class PartnerCancel {
  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Icon(Icons.warning),
          title: Text(title),
          subtitle: Text(message),
        ),
        actions: [TextButton(onPressed: () {}, child: Text('OK'))],
      ),
    );
  }
}
