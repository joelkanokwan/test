import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:joelfindtechnician/alertdialog/my_dialog.dart';
import 'package:joelfindtechnician/alertdialog/select_province.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';

class FormContactPartner extends StatefulWidget {
  final PostCustomerModel? postCustomerModel;
  const FormContactPartner({
    Key? key,
    this.postCustomerModel,
  }) : super(key: key);

  @override
  _FormContactPartnerState createState() => _FormContactPartnerState();
}

class _FormContactPartnerState extends State<FormContactPartner> {
  DateTime? date;
  TimeOfDay? time;

  File? image;
  String? imgUrl;

  PostCustomerModel? postCustomerModel;

  final _formKey = GlobalKey<FormState>();

  String getTime() {
    if (time == null) {
      return 'Appointment Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  String getDate() {
    if (date == null) {
      return 'Appointment Date';
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (newDate == null) return;

    setState(() => date = newDate);
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() {
      time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 18),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  newName(),
                  SizedBox(height: 10),
                  newPhone(),
                  SizedBox(height: 10),
                  newEmail(),
                  SizedBox(height: 10),
                  newAddress(),
                  SizedBox(height: 15),
                  newLocation(),
                  SizedBox(height: 15),
                  newAppointment(context),
                  buttonSentForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buttonSentForm() {
    return Container(
      height: 50,
      width: 330,
      child: FlatButton(
        textColor: Colors.white,
        color: Colors.blueAccent,
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        child: Text(
          'Sent foam to technician',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Row newAppointment(BuildContext context) {
    return Row(
      children: [
        FlatButton.icon(
          onPressed: () {
            pickDate(context);
          },
          icon: Icon(
            Icons.date_range_outlined,
            size: 30,
            color: Colors.orange,
          ),
          label: Text(getDate()),
        ),
        FlatButton.icon(
          padding: EdgeInsets.only(right: 10),
          onPressed: () {
            pickTime(context);
          },
          icon: Icon(
            Icons.watch_later_outlined,
            size: 30,
            color: Colors.orange,
          ),
          label: Text(getTime()),
        ),
      ],
    );
  }

  Row newLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text('ตำบล'),
        ),
        Container(
          child: Text('อำเภอ'),
        ),
        Container(
          child: Text('จังหวัด'),
        ),
      ],
    );
  }

  TextFormField newAddress() {
    return TextFormField(
      validator: (value) {},
      decoration: InputDecoration(
        labelText: 'Address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  TextFormField newEmail() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please type your email address';
        } else {}
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  TextFormField newPhone() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please type your phone number';
        } else {}
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  TextFormField newName() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please type your name';
        } else {}
      },
      decoration: InputDecoration(
        labelText: 'Customer Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text('Foam contact technician'),
    );
  }
}
