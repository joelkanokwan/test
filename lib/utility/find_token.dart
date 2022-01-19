import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FindToken {
  Future<String> processFindToken() async {
    String? token;

    await Firebase.initializeApp().then((value) {});
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    token = await firebaseMessaging.getToken();

    
    return token ?? '';
  }
}
