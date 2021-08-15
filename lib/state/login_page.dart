import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/social_service.dart';
import 'package:joelfindtechnician/state/partner_signin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    indicator() {
      return Container(
        width: 6,
        height: 6,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      );
    }

    activeIndicator() {
      return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Container(
          width: 6,
          height: 6,
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(children: [
        CarouselSlider(
          items: [0, 1, 2, 3].map((item) {
            return Image.asset('assets/images/display_login.jpg');
          }).toList(),
          options: CarouselOptions(
            height: double.infinity,
            autoPlay: true,
            viewportFraction: 1,
            initialPage: currentIndex,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 60),
          child: Row(
            children: [0, 1, 2, 3].map((item) {
              if (item == currentIndex) return activeIndicator();
              return indicator();
            }).toList(),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 36,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 320,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: SignInButton(
                    Buttons.FacebookNew,
                    onPressed: () {
                      SocialService().loginfb(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Container(
                  width: 320,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      SocialService().googlesignIn(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                ),
                Container(
                  width: 320,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: SignInButton(
                    Buttons.AppleDark,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(13),
                  ),
                ),
                Container(
                  child: FlatButton(
                      textColor: Colors.black,
                      child: Text(
                        "Partner Click!",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => PartnerSignin(),
                          ),
                        );
                      }),
                ),
                Container(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
