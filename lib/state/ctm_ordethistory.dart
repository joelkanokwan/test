import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/social_service.dart';
import 'package:joelfindtechnician/state/ctm_aboutus.dart';
import 'package:joelfindtechnician/state/ctm_contactus.dart';
import 'package:joelfindtechnician/state/ctm_howtouseapp.dart';
import 'package:joelfindtechnician/state/ctm_notification.dart';
import 'package:joelfindtechnician/state/ctm_termandconditon.dart';
import 'package:joelfindtechnician/state/login_page.dart';
import 'package:joelfindtechnician/state/login_success.dart';

class CustomerOrderHistory extends StatefulWidget {
  const CustomerOrderHistory({Key? key}) : super(key: key);

  @override
  _CustomerOrderHistoryState createState() => _CustomerOrderHistoryState();
}

class _CustomerOrderHistoryState extends State<CustomerOrderHistory> {
  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
          title: Text('Customer OrderHistory'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.work_outline_outlined),
                text: 'current job',
              ),
              Tab(
                icon: Icon(Icons.cancel_outlined),
                text: 'canceled',
              ),
              Tab(
                icon: Icon(Icons.design_services_outlined),
                text: 'eddit job',
              ),
              Tab(
                icon: Icon(Icons.done_outline),
                text: 'job done',
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: Material(
            color: Colors.blue,
            child: ListView(
              children: [
                DrawerHeader(
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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person_outline,
                    ),
                    title: Text('My Profile'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginSuccess(),
                          ),
                          (route) => false);
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
      ),
    );
  }
}
