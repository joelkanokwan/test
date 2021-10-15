import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyConstant {
  static List<String> adminEmails = ['iam@gmail.com', 'master@abc.com'];
  static String urlNoAvatar =
      'https://firebasestorage.googleapis.com/v0/b/joelfindtechnician.appspot.com/o/Images%2FiconMasterUng%202.png?alt=media&token=c8ccc4f4-7f4a-4957-8615-ee7cef548ef0';

  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2StyleWhite() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );
  TextStyle h4Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
