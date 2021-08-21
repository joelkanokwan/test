import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/alertdialog/cancelReportform_success.dart';
import 'package:joelfindtechnician/alertdialog/jobdone_success.dart';
import 'package:joelfindtechnician/partner_state/appointment_form.dart';
import 'package:joelfindtechnician/partner_state/cancel_form.dart';
import 'package:joelfindtechnician/partner_state/confirmReportform.dart';
import 'package:joelfindtechnician/partner_state/job_done.dart';

import 'package:joelfindtechnician/partner_state/offerprice_form.dart';

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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Jobdone()));
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.done_all_outlined,
          ),
          label: 'Job done',
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '**Cuustomer sent form to technician**',
                        style: GoogleFonts.lato(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Customer Name',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Appointment :',
                          ),
                          SizedBox(width: 10),
                          Text(
                            'xxxxxxxxxx',
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Order Summit :',
                          ),
                          SizedBox(width: 10),
                          Text(
                            'xxxxxxxxxx',
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Expire time:',
                            style: GoogleFonts.lato(color: Colors.red),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'xxxxxxxxxx',
                            style: GoogleFonts.lato(color: Colors.red),
                          ),
                        ],
                      ),
                      Divider(thickness: 2),
                      Text(
                        'Job Description :',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                      ),
                      Divider(thickness: 2),
                      Text(
                        'Remark :',
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '**Technician make form confirm to system**',
                        style: GoogleFonts.lato(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Customer Name',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Appointment time :',
                          ),
                          SizedBox(width: 10),
                          Text(
                            'xxxxxxxxxx',
                          ),
                        ],
                      ),
                      Divider(thickness: 2),
                      Text(
                        'Confirm Job :',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'xxxxxxxxxxxxxxx',
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text(
                            'Total Price :',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('xxxxx'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
