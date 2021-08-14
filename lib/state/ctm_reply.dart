import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/alertdialog/ctmCancel_success.dart';
import 'package:joelfindtechnician/state/appointment_form.dart';
import 'package:joelfindtechnician/state/cancel_form.dart';
import 'package:joelfindtechnician/state/payment_method.dart';

class CustomerReply extends StatefulWidget {
  const CustomerReply({Key? key}) : super(key: key);

  @override
  _PartnerReplyState createState() => _PartnerReplyState();
}

class _PartnerReplyState extends State<CustomerReply> {
  SpeedDial _speedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 25),
      children: [
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PaymentsMethod()));
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.reply,
          ),
          label: 'Confirm job',
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
                context, MaterialPageRoute(builder: (context) => CustomerCancelSuccess()));
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
        title: Text('Customer Reply Page'),
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
