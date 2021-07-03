import 'package:flutter/material.dart';
import 'package:joelfindtechnician/social_service.dart';
import 'package:joelfindtechnician/state/partner_signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('You are logged in'),
      ElevatedButton(
          onPressed: () {
            SocialService().signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PartnerSignin(),
              ),
            );
          },
          child: Center(child: Text('LOG OUT')))
    ]));
  }
}
