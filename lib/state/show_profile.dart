import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/eddit_profile.dart';
import 'package:joelfindtechnician/state/foamcontact_partner.dart';
import 'package:joelfindtechnician/state/home_page.dart';
import 'package:joelfindtechnician/state/mywallet.dart';
import 'package:joelfindtechnician/state/partner_aboutus.dart';
import 'package:joelfindtechnician/state/partner_contactus.dart';
import 'package:joelfindtechnician/state/partner_howtouseapp.dart';
import 'package:joelfindtechnician/state/partner_notification.dart';
import 'package:joelfindtechnician/state/partner_orderhistory.dart';
import 'package:joelfindtechnician/state/partner_signin.dart';
import 'package:joelfindtechnician/state/partner_termandconditon.dart';
import 'package:joelfindtechnician/state/show_review.dart';
import 'package:joelfindtechnician/state/social_service.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({Key? key}) : super(key: key);

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  final databaseReference = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser!;
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
        title: Text('Show Profile'),
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
                  title: Text('My Profile'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false);
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
                            builder: (context) => PartnerTermAndCondiotion()));
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Product').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map(
            (e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(e['img']),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      e['name'],
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Text(
                      e['about'],
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 5, top: 8),
                        child: FlatButton(
                          height: 40,
                          minWidth: 170,
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowReview()));
                          },
                          child: Text(
                            'Review',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: FlatButton(
                          height: 40,
                          minWidth: 170,
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FoamContactPartner()));
                          },
                          child: Text(
                            'Contact',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ).toList());
        },
      ),
    );
  }
}
