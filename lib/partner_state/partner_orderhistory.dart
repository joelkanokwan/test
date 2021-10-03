import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/community_page.dart';
import 'package:joelfindtechnician/partner_state/eddit_profile.dart';
import 'package:joelfindtechnician/partner_state/home_page.dart';
import 'package:joelfindtechnician/partner_state/mywallet.dart';
import 'package:joelfindtechnician/partner_state/partner_aboutus.dart';
import 'package:joelfindtechnician/partner_state/partner_contactus.dart';
import 'package:joelfindtechnician/partner_state/partner_howtouseapp.dart';
import 'package:joelfindtechnician/partner_state/partner_notification.dart';
import 'package:joelfindtechnician/partner_state/partner_signin.dart';
import 'package:joelfindtechnician/partner_state/partner_termandconditon.dart';
import 'package:joelfindtechnician/partner_state/social_service.dart';

class PartnerOrderHistory extends StatefulWidget {
  const PartnerOrderHistory({Key? key}) : super(key: key);

  @override
  _PartnerOrderHistoryState createState() => _PartnerOrderHistoryState();
}

class _PartnerOrderHistoryState extends State<PartnerOrderHistory>
    with SingleTickerProviderStateMixin {
  TabController? _tabPartnerOrderhistorycontroller;
  @override
  void initState() {
    super.initState();
    _tabPartnerOrderhistorycontroller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabPartnerOrderhistorycontroller!.dispose();
  }

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
          title: Text('Partner History'),
          bottom: TabBar(
            controller: _tabPartnerOrderhistorycontroller,
            tabs: [
              Tab(
                icon: Icon(Icons.work_outline_outlined),
                text: 'current job',
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
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false);
                  },
                  child: DrawerHeader(
                    padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 20, backgroundColor: Colors.blue),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                      Icons.auto_fix_off,
                    ),
                    title: Text('Eddit Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EdditProfile()));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet_outlined,
                    ),
                    title: Text('My Wallet'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyWallet()));
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
                              builder: (context) => PartnerNotification()));
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
                              builder: (context) => PartnerOrderHistory()));
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
                              builder: (context) => PartnerAboutUs()));
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
                              builder: (context) => PartnerContactUs()));
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
                              builder: (context) => PartnerHowtoUseApp()));
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
                              builder: (context) =>
                                  PartnerTermAndCondiotion()));
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PartnerSignin()),
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
