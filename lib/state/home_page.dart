import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/eddit_profile.dart';

import 'package:joelfindtechnician/social_service.dart';
import 'package:joelfindtechnician/state/partner_signin.dart';
import 'package:joelfindtechnician/state/show_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              height: 125,
              width: 200,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      "Hello",
                      style: GoogleFonts.fredokaOne(
                        fontSize: 60,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        "There",
                        style: GoogleFonts.fredokaOne(
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                ' ' + User.email!,
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 50,
              width: 330,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: FlatButton(
                textColor: Colors.black,
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ShowProfile(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    Text(
                      "My Profile",
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 100),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 330,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: FlatButton(
                textColor: Colors.black,
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => EdditProfile()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    Text(
                      "Edit Profile",
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 95),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 330,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: FlatButton(
                textColor: Colors.black,
                color: Colors.blueGrey,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    Text(
                      "Order History",
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 71),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 330,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: FlatButton(
                textColor: Colors.black,
                color: Colors.blueGrey,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    Text(
                      "Contact Us",
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 98),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 330,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: FlatButton(
                textColor: Colors.black,
                color: Colors.blueGrey,
                onPressed: () {
                  SocialService().signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => PartnerSignin(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    Text(
                      "SignOut",
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.power_settings_new),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
