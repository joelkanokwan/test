import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:joelfindtechnician/models/token_model.dart';

class FindToken {
  Future<String?> processFindTokenByDocUser({required String docUser}) async {
    String? token;

    var result = await FirebaseFirestore.instance
        .collection('user')
        .doc(docUser)
        .collection('mytoken')
        .get();

    for (var item in result.docs) {
      TokenModel tokenModel = TokenModel.fromMap(item.data());
      token = tokenModel.token;
    }

    return token;
  }

  Future<String> processFindToken() async {
    String? token;

    await Firebase.initializeApp().then((value) {});
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    token = await firebaseMessaging.getToken();

    return token ?? '';
  }
}
