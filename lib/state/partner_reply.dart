import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/alertdialog/cancelReportform_success.dart';
import 'package:joelfindtechnician/state/appointment_form.dart';
import 'package:joelfindtechnician/state/cancel_form.dart';
import 'package:joelfindtechnician/state/confirmReportform.dart';
import 'package:joelfindtechnician/state/offerprice_form.dart';

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
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmReportForm()));
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.check_circle_outline,
          ),
          label: 'Confirm report form',
          labelBackgroundColor: Colors.amber,
          labelStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CancelReportFormSuccess()));
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.cancel_presentation_outlined,
          ),
          label: 'Cancel report form',
          labelBackgroundColor: Colors.amber,
          labelStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AppointmentForm()));
          },
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
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OfferPriceForm()));
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.reply,
          ),
          label: 'Offer price',
          labelBackgroundColor: Colors.amber,
          labelStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CancelForm()));
          },
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
        title: Text('Partner Reply Page'),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(Icons.emoji_emotions_outlined),
            ),
          ),
        ],
      ),
      floatingActionButton: _speedDial(),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 20),
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 1,
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            ),
          ],
        ),
      ),
    );
  }
}
