import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/alertdialog/alert_detail.dart';
import 'package:joelfindtechnician/alertdialog/choose_jobscope.dart';
import 'package:joelfindtechnician/alertdialog/my_dialog.dart';
import 'package:joelfindtechnician/alertdialog/select_province.dart';
import 'package:joelfindtechnician/alertdialog/success_register.dart';
import 'package:joelfindtechnician/gsheet/controller.dart';
import 'package:joelfindtechnician/gsheet/model.dart';
import 'package:joelfindtechnician/models/user_model.dart';
import 'package:joelfindtechnician/partner_state/partner_signin.dart';

class RegisterPartner extends StatefulWidget {
  @override
  _RegisterPartnerState createState() => _RegisterPartnerState();
}

class _RegisterPartnerState extends State<RegisterPartner> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumberlController = TextEditingController();
  TextEditingController jobtypeController = TextEditingController();
  TextEditingController jobscopeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<Null> checkNameAndAddData() async {
    await Firebase.initializeApp().then((value) async {
      print('Initial Success');
      await FirebaseFirestore.instance
          .collection('user')
          .where('name', isEqualTo: nameController.text)
          .snapshots()
          .listen((event) async {
        print('event ==> ${event.docs}');
        if (event.docs.length == 0) {
          print('ชื่อร้านไม่ซ้ำ');

          UserModelFirebase userModelFirebase = UserModelFirebase(
            email: emailController.text,
            uid: '',
            name: nameController.text,
            phoneNumber: phonenumberlController.text,
            jobType: jobtypeController.text,
            jobScope: jobscopeController.text,
            address: addressController.text,
            accept: false,
            about: '',
            img: '',
          );

          await FirebaseFirestore.instance
              .collection('user')
              .doc()
              .set(userModelFirebase.toMap())
              .then((value) {
            print('Insert Data Success');

            insertValueToSheet();
          });
        } else {
          print('ชื่อร้านซ้ำ');
          MyDialog()
              .normalDialog(context, 'ชื่อร้านซ้ำ', 'เปลี่ยนชื่อร้านใหม่');
        }
      });
    });
  }

  void insertValueToSheet() {
    RegisterFoam registerFoam = RegisterFoam(
      nameController.text,
      phonenumberlController.text,
      jobtypeController.text,
      jobscopeController.text,
      addressController.text,
      emailController.text,
    );
    FormController formController = FormController();
    showDialog(
      context: context,
      builder: (context) => SuccessRegister(
        title: "",
        discription: "",
        buttonText: "",
      ),
    );
    _formKey.currentState!.reset();
    _showSnackbar("");
    formController.submitForm(registerFoam, (String response) {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        _showSnackbar("Submitted");
      } else {
        _showSnackbar("Error Occurred!");
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      checkNameAndAddData();
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PartnerSignin(),
            ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "ลงทะเบียนพาร์ทเนอร์",
          style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุชื่อสกุล/ห้างร้าน/บริษัท';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "ชื่อสกุล/ห้างร้าน/บริษัท",
                      labelStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: phonenumberlController,
                    validator: (value) {
                      if (value!.trim().length != 10) {
                        return 'กรุณาระบุหมายเลขโทรศัพท์ให้ถูกต้อง';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "หมายเลขโทรศัพท์",
                      labelStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุอีเมล์';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "อีเมล์",
                      labelStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: jobscopeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุขอบเขตการทำงาน';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "ขอบเขตการทำงาน",
                      labelStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุที่อยู่ปัจจุบัน';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "ที่อยู่ปัจจุบัน/ที่ตั้งห้างร้าน/บริษัท",
                      labelStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: FlatButton.icon(
                          onPressed: () {
                            SelectProvince().normalDialog(context);
                          },
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.orange,
                          ),
                          label: Text(
                            'จังหวัด',
                            style: GoogleFonts.lato(fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.orange,
                          ),
                          label: Text(
                            'อำเภอ',
                            style: GoogleFonts.lato(fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.orange,
                          ),
                          label: Text(
                            'ตำบล',
                            style: GoogleFonts.lato(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 230,
                    child: FlatButton.icon(
                      onPressed: () {
                        ChooseJobScope().normalDialog(context);
                      },
                      icon: Icon(
                        Icons.work_outline_outlined,
                        color: Colors.orange,
                      ),
                      label: Text(
                        'ประเภทของงาน',
                        style: GoogleFonts.lato(fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 330,
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      child: Text(
                        'ตกลง',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _submitForm,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDetail(
                            title: "",
                            discription: "",
                            buttonText: "",
                          ),
                        );
                      },
                      child: Text(
                        'สนใจร่วมเป็นพาร์ทเนอร์ต้องทำยังไง ?',
                        style: GoogleFonts.lato(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
