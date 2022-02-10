import 'package:dio/dio.dart';

class ProcessSentNotiByToken {
  String token;
  String title;
  String body;
  ProcessSentNotiByToken({
    required this.token,
    required this.title,
    required this.body,
  });

  Future<void> sentNoti() async {
    String apiSentNotification =
        'https://www.androidthai.in.th/eye/apiNotification.php?isAdd=true&token=$token&title=$title&body=$body';
    await Dio()
        .get(apiSentNotification)
        .then((value) => print('Sent Noti Success'))
        .onError((error, stackTrace) => print('#1feb error ${error.toString()}'));
  }
}
