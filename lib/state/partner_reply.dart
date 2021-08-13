import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerReply extends StatefulWidget {
  const PartnerReply({Key? key}) : super(key: key);

  @override
  _PartnerReplyState createState() => _PartnerReplyState();
}

class _PartnerReplyState extends State<PartnerReply> {
  SpeedDial _speedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 25),
      children: [
        SpeedDialChild(
          onTap: () {},
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.calendar_today_outlined,
          ),
          label: 'Appointment',
          labelBackgroundColor: Colors.amber,
          labelStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SpeedDialChild(
          onTap: () {},
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.reply,
          ),
          label: 'Reply',
          labelBackgroundColor: Colors.amber,
          labelStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SpeedDialChild(
          onTap: () {},
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.cancel_outlined,
          ),
          label: 'cancel',
          labelBackgroundColor: Colors.amber,
          labelStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Partner Reply'),
      ),
      floatingActionButton: _speedDial(),
    );
  }
}
