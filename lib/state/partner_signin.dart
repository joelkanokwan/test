import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/state/social_service.dart';
import 'package:joelfindtechnician/state/forget_password.dart';
import 'package:joelfindtechnician/state/login_page.dart';
import 'package:joelfindtechnician/state/register_partner.dart';
import 'package:joelfindtechnician/state/sign_up.dart';

class PartnerSignin extends StatefulWidget {
  const PartnerSignin({Key? key}) : super(key: key);

  @override
  _PartnerSigninState createState() => _PartnerSigninState();
}

class _PartnerSigninState extends State<PartnerSignin> {
  final formKey = new GlobalKey<FormState>();

  late String email, password;

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp("");
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(children: [
            SizedBox(height: 50),
            Container(
              height: 125,
              width: 200,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      "Signin",
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
                        "Partner",
                        style: GoogleFonts.fredokaOne(
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          onChanged: (value) {
                            this.email = value;
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Pleae Enter Email Address'
                              : validateEmail(value)),
                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            this.password = value;
                          },
                          validator: (value) =>
                              value!.isEmpty ? 'Please Enter Password' : null),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ForgetPassword(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment(1, 0),
                          padding: EdgeInsets.only(top: 15, left: 20),
                          child: Text(
                            "Forget Password",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 50,
                        width: 330,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (checkFields())
                              SocialService().signIn(email, password, context);
                          },
                          child: Text(
                            "Signin",
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => RegisterPartner(),
                                ),
                              );
                            },
                            child: Text(
                              "Join our Partner ?",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              "Signup",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
