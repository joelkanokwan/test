import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joelfindtechnician/models/replypost_model.dart';

class DetailNotiSocial extends StatefulWidget {
  final String reply;
  const DetailNotiSocial({Key? key, required this.reply}) : super(key: key);

  @override
  _DetailNotiSocialState createState() => _DetailNotiSocialState();
}

class _DetailNotiSocialState extends State<DetailNotiSocial> {
  String? reply;

  @override
  void initState() {
    super.initState();
    reply = widget.reply;
    print('#12jan job ==> $reply');
    readPostCustomer();
  }

  Future<void> readPostCustomer() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('postcustomer')
          .get()
          .then((value) async {
        for (var item in value.docs) {
          String docIdPostCustomer = item.id;
          await FirebaseFirestore.instance
              .collection('postcustomer')
              .doc(docIdPostCustomer)
              .collection('replypost')
              .get()
              .then((value) async {
            if (value.docs.isNotEmpty) {
              await FirebaseFirestore.instance
                  .collection('postcustomer')
                  .doc(docIdPostCustomer)
                  .collection('replypost')
                  .where('reply', isEqualTo: reply)
                  .get()
                  .then((value) {
                for (var item in value.docs) {
                  ReplyPostModel replyPostModel =
                      ReplyPostModel.fromMap(item.data());
                  print('#12jan uid ==> ${replyPostModel.uid}');
                }
              });
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Noti Social'),
      ),
      body: Text('body'),
    );
  }
}
