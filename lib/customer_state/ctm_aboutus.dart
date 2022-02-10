import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/customer_state/ctm_contactus.dart';
import 'package:joelfindtechnician/customer_state/ctm_howtouseapp.dart';
import 'package:joelfindtechnician/customer_state/ctm_notification.dart';
import 'package:joelfindtechnician/customer_state/ctm_ordethistory.dart';
import 'package:joelfindtechnician/customer_state/ctm_termandconditon.dart';
import 'package:joelfindtechnician/state/login_page.dart';
import 'package:joelfindtechnician/customer_state/login_success.dart';
import 'package:joelfindtechnician/customer_state/social_service.dart';
import 'package:joelfindtechnician/state/community_page.dart';

class CustomerAboutUs extends StatefulWidget {
  const CustomerAboutUs({Key? key}) : super(key: key);

  @override
  _CustomerAboutUsState createState() => _CustomerAboutUsState();
}

class _CustomerAboutUsState extends State<CustomerAboutUs> {
  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text('Customer AboutUs'),
      ),
    );
  }
}
