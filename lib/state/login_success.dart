import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/social_service.dart';
import 'package:joelfindtechnician/state/login_page.dart';

class LoginSuccess extends StatefulWidget {
  @override
  _LoginSuccessState createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/screen.png'),
                  fit: BoxFit.cover),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(User.photoURL!),
                ),
                SizedBox(height: 8),
                Text(
                  '' + User.displayName!,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  ' ' + User.email!,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height: 45,
                  width: 300,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: FlatButton.icon(
                    textColor: Colors.black,
                    color: Colors.blueGrey,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.home),
                    ),
                    label: Text(
                      'Back to Service',
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 300,
                  margin: EdgeInsets.fromLTRB(16, 3, 16, 8),
                  child: FlatButton.icon(
                    textColor: Colors.black,
                    color: Colors.blueGrey,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.shopping_bag),
                    ),
                    label: Text(
                      '    Order history',
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 300,
                  margin: EdgeInsets.fromLTRB(16, 3, 16, 8),
                  child: FlatButton.icon(
                    textColor: Colors.black,
                    color: Colors.blueGrey,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.message),
                    ),
                    label: Text(
                      '   Contact  Us   ?',
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 300,
                  margin: EdgeInsets.fromLTRB(16, 3, 16, 8),
                  child: FlatButton.icon(
                    textColor: Colors.black,
                    color: Colors.blueGrey,
                    onPressed: () {
                      SocialService().signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: Icon(Icons.power_settings_new),
                    label: Text(
                      'Logout',
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
