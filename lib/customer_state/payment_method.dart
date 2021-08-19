import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/community_page.dart';
import 'package:joelfindtechnician/customer_state/ctm_aboutus.dart';
import 'package:joelfindtechnician/customer_state/ctm_contactus.dart';
import 'package:joelfindtechnician/customer_state/ctm_howtouseapp.dart';
import 'package:joelfindtechnician/customer_state/ctm_notification.dart';
import 'package:joelfindtechnician/customer_state/ctm_ordethistory.dart';
import 'package:joelfindtechnician/customer_state/ctm_termandconditon.dart';
import 'package:joelfindtechnician/customer_state/login_page.dart';
import 'package:joelfindtechnician/customer_state/login_success.dart';
import 'package:joelfindtechnician/partner_state/social_service.dart';

class PaymentsMethod extends StatefulWidget {
  const PaymentsMethod({Key? key}) : super(key: key);

  @override
  _PaymentsMethodState createState() => _PaymentsMethodState();
}

class _PaymentsMethodState extends State<PaymentsMethod> {
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
        title: Text('Payments Method'),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 100),
        padding: EdgeInsets.all(30),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Card(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.qr_code_outlined,
                        color: Colors.orange,
                        size: 70,
                      ),
                      Text(
                        'QR Code',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.waterfall_chart,
                        color: Colors.orange,
                        size: 70,
                      ),
                      Text(
                        'Ali Pay',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.money_rounded,
                        color: Colors.orange,
                        size: 70,
                      ),
                      Text(
                        'CryptoCurrency',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.table_chart_outlined,
                        color: Colors.orange,
                        size: 70,
                      ),
                      Text(
                        'Bill Payment',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.credit_card_outlined,
                        color: Colors.orange,
                        size: 70,
                      ),
                      Text(
                        'Credit Card',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.credit_card_outlined,
                        color: Colors.orange,
                        size: 70,
                      ),
                      Text(
                        'Debit Card',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Material(
          color: Colors.blue,
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginSuccess(),
                      ),
                      (route) => false);
                },
                child: DrawerHeader(
                  padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(User.photoURL!)),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            User.displayName!,
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            User.email!,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                  ),
                  title: Text('Go to services'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommunityPage()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.notification_important_outlined,
                  ),
                  title: Text('Notification'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerNotification()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_bag_outlined,
                  ),
                  title: Text('Order History'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerOrderHistory()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(Icons.person_pin_circle_sharp),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerAboutUs()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.message_outlined,
                  ),
                  title: Text(
                    'Contact Us',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerContactUs()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.label_important_outlined,
                  ),
                  title: Text('How to use App'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerHowtouseApp()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.warning_amber_outlined,
                  ),
                  title: Text('Term and Conditon'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerTermandConditon()));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Icons.power_settings_new,
                  ),
                  title: Text('SignOut'),
                  onTap: () {
                    SocialService().signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
