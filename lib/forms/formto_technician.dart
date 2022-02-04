import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/alertdialog/my_dialog.dart';
import 'package:joelfindtechnician/forms/check_detail.dart';
import 'package:joelfindtechnician/models/answer_model.dart';
import 'package:joelfindtechnician/models/appointment_model.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';
import 'package:joelfindtechnician/models/replypost_model.dart';
import 'package:joelfindtechnician/models/social_my_notification.dart';
import 'package:joelfindtechnician/state/show_circleavatar.dart';
import 'package:joelfindtechnician/state/show_image_post.dart';
import 'package:joelfindtechnician/utility/find_user_by_uid.dart';
import 'package:joelfindtechnician/utility/process_sent_noti_by_token.dart';
import 'package:joelfindtechnician/utility/time_to_string.dart';
import 'package:joelfindtechnician/widgets/show_form.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';
import 'package:joelfindtechnician/widgets/show_image_network.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';
import 'package:joelfindtechnician/widgets/show_text.dart';

class FormtoTechnician extends StatefulWidget {
  final String? docIdAppointment;
  final AppointmentModel? appointmentModel;
  const FormtoTechnician({
    Key? key,
    this.docIdAppointment,
    this.appointmentModel,
  }) : super(key: key);

  @override
  _FormtoTechnicianState createState() => _FormtoTechnicianState();
}

class _FormtoTechnicianState extends State<FormtoTechnician> {
  String? docIdAppointment;
  AppointmentModel? appointmentModel;
  var uidTechnic = FirebaseAuth.instance.currentUser!.uid;

  String? expMinus;
  bool showButton = false;

  var replyPostModels = <ReplyPostModel>[];
  PostCustomerModel? postcustomerModel;
  var listAnswerModels = <List<AnswerModel>>[];

  String? detailOfWork, warranty, totalPrice;

  @override
  void initState() {
    super.initState();
    docIdAppointment = widget.docIdAppointment;
    appointmentModel = widget.appointmentModel;
    readCustomerPost();

    if (docIdAppointment != null) {
      checkApprove();
    }
  }

  Future<void> readCustomerPost() async {
    await FirebaseFirestore.instance
        .collection('postcustomer')
        .doc(appointmentModel!.docIdPostcustomer)
        .get()
        .then((value) {
      setState(() {
        postcustomerModel = PostCustomerModel.fromMap(value.data()!);
      });
    });

    await FirebaseFirestore.instance
        .collection('postcustomer')
        .doc(appointmentModel!.docIdPostcustomer)
        .collection('replypost')
        .get()
        .then((value) async {
      for (var item in value.docs) {
        ReplyPostModel replyPostModel = ReplyPostModel.fromMap(item.data());
        var answerModels = <AnswerModel>[];

        await FirebaseFirestore.instance
            .collection('postcustomer')
            .doc(appointmentModel!.docIdPostcustomer)
            .collection('replypost')
            .doc(item.id)
            .collection('answer')
            .get()
            .then((value) {
          for (var item in value.docs) {
            AnswerModel answerModel = AnswerModel.fromMap(item.data());
            answerModels.add(answerModel);
          }
        });

        setState(() {
          replyPostModels.add(replyPostModel);
          listAnswerModels.add(answerModels);
        });
      }
    });
  }

  Future<void> calculateExpireMinus() async {
    DateTime currentDateTime = DateTime.now();
    DateTime contactDateTime = appointmentModel!.timeContact.toDate();
    contactDateTime = DateTime(
      contactDateTime.year,
      contactDateTime.month,
      contactDateTime.day,
      contactDateTime.hour,
      contactDateTime.minute + 60,
      contactDateTime.second,
    );

    print('#3 current ==> $currentDateTime, contact ==> $contactDateTime');

    if (currentDateTime.isBefore(contactDateTime)) {
      var minusInt = contactDateTime.difference(currentDateTime).inMinutes;
      Duration duration = Duration(minutes: minusInt);
      Duration duration1 = Duration(seconds: 10);

      print('#3feb ก่อนหมดเวลา minusInt ==>> $minusInt นาที');
      Timer(duration, () {
        print('#3feb Calculate Work');
        processNonApprove(label: 'TimeOut');
      });

      setState(() {
        expMinus = 'ก่อนหมดเวลา $minusInt นาที';
        showButton = true;
      });
    } else {
      print('#2feb หมดเวลาแล้ว');
      setState(() {
        expMinus = 'หมดเวลาแล้ว';
      });
    }
  }

  Future<void> checkApprove() async {
    var docUser = await FindUserByUid(uid: uidTechnic).getDocUser();

    print('#2feb docIdAppoint ==> $docIdAppointment, uidTech = $uidTechnic');
    print('#2feb docUser = $docUser');
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docUser)
        .collection('appointment')
        .doc(docIdAppointment)
        .get()
        .then((value) async {
      Map<String, dynamic>? map = value.data();
      AppointmentModel appointmentModel = AppointmentModel.fromMap(map!);
      print('#2febapprove ==>> ${appointmentModel.approve}');
      String approve = appointmentModel.approve;
      if (approve == 'unread') {
        Map<String, dynamic> data = {};
        data['approve'] = 'read';
        await FirebaseFirestore.instance
            .collection('user')
            .doc(docUser)
            .collection('appointment')
            .doc(docIdAppointment)
            .update(data)
            .then((value) => calculateExpireMinus());
      } else if (approve == 'NonApprove') {
        setState(() {
          expMinus = 'Non Approve';

          showButton = false;
        });
      } else if (approve == 'Confirm') {
        expMinus = 'Confirm';
        showButton = false;
      } else {
        calculateExpireMinus();
      }
    });
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
        title: Text('Form to technician'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
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
                          appointmentModel!.customerName,
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Appointment:',
                            ),
                            SizedBox(width: 10),
                            Text(
                              TimeToString(
                                      timestamp:
                                          appointmentModel!.timeAppointment)
                                  .findString(),
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
                              expMinus ?? '',
                              style: GoogleFonts.lato(color: Colors.red),
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        ShowForm(
                          label: 'Detail of work:',
                          changeFunc: (String? string) =>
                              detailOfWork = string!.trim(),
                        ),
                        Divider(thickness: 2),
                        ShowForm(
                          label: 'Warantty :',
                          changeFunc: (String? string) =>
                              warranty = string!.trim(),
                        ),
                        Divider(thickness: 2),
                        ShowForm(
                          label: 'Totl Price :',
                          changeFunc: (String? string) =>
                              totalPrice = string!.trim(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              postcustomerModel == null
                  ? ShowProgress()
                  : Row(
                      children: [
                        ShowCircleAvatar(url: postcustomerModel!.pathUrl),
                        ShowText(title: postcustomerModel!.name),
                      ],
                    ),
              ShowText(
                  title:
                      postcustomerModel == null ? '' : postcustomerModel!.job),
              replyPostModels.isEmpty
                  ? ShowProgress()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: replyPostModels.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 36),
                              ShowCircleAvatar(
                                  url: replyPostModels[index].pathImage),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShowText(title: replyPostModels[index].name),
                                  ShowText(title: replyPostModels[index].reply),
                                ],
                              ),
                            ],
                          ),
                          ShowImageNetWork(
                              urlPath: replyPostModels[index].urlImagePost,
                              tapFunc: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowImagePost(
                                        pathImage: replyPostModels[index]
                                            .urlImagePost),
                                  ))),
                          ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listAnswerModels[index].length,
                            itemBuilder: (context, index2) => Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 80),
                                    ShowCircleAvatar(
                                        url: listAnswerModels[index][index2]
                                            .urlPost),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ShowText(
                                          title: listAnswerModels[index][index2]
                                              .namePost,
                                        ),
                                        ShowText(
                                          title: listAnswerModels[index][index2]
                                              .answer,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ShowImageNetWork(
                                    urlPath: listAnswerModels[index][index2]
                                        .urlImage,
                                    tapFunc: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowImagePost(
                                                    pathImage:
                                                        listAnswerModels[index]
                                                                [index2]
                                                            .urlImage,
                                                  )),
                                        )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
              showButton
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        confirmButton(context),
                        SizedBox(width: 10),
                        cancelButton(context),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton confirmButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if ((detailOfWork?.isEmpty ?? true) ||
            (warranty?.isEmpty ?? true) ||
            (totalPrice?.isEmpty ?? true)) {
          MyDialog()
              .normalDialog(context, 'Have space', 'Please fill something');
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: ListTile(
                leading: ShowImage(),
                title: ShowText(title: 'Confirm Job'),
                subtitle: ShowText(title: 'If Confime will cannot change'),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    print('3efbeb you click ok');

                    await processNonApprove(label: 'Confirm')
                        .then((value) async {
                      print('#3feb noti confirm success');

                      var uid = await FirebaseAuth.instance.currentUser!.uid;
                      var docIdTechnic =
                          await FindUserByUid(uid: uid).getDocUser();

                          Timestamp  timestamp = Timestamp.fromDate(DateTime.now());

                      SocialMyNotificationModel socialMyNotification =
                          SocialMyNotificationModel(
                        docIdPostCustomer: appointmentModel!.docIdPostcustomer,
                        docIdTechnic: docIdTechnic!, timeConfirm: timestamp, readed: false,
                      );

                      await FirebaseFirestore.instance
                          .collection('social')
                          .doc(appointmentModel!.uidSocial)
                          .collection('myNotification')
                          .doc()
                          .set(socialMyNotification.toMap())
                          .then((value) {
                        print('#3feb Insert myNoti Success');
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          );
        }
      },
      child: Text('Confirm'),
    );
  }

  ElevatedButton cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: ListTile(
              leading: ShowImage(),
              title: ShowText(title: 'Cancel'),
              subtitle: ShowText(title: 'Confirm to cancel this job ?'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  print('you ok');
                  Navigator.pop(context);
                  processNonApprove(label: 'NonApprove');
                },
                child: Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
      child: Text('Cancel'),
    );
  }

  Future<void> processNonApprove({required String label}) async {
    var uidLogin = await FirebaseAuth.instance.currentUser!.uid;
    var docIdUser = await FindUserByUid(uid: uidLogin).getDocUser();
    var userModelOld = await FindUserByUid(uid: uidLogin).getUserModel();

    Map<String, dynamic> map = {};
    map['approve'] = label;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docIdUser)
        .collection('appointment')
        .doc(docIdAppointment)
        .update(map)
        .then((value) async {
      print('update Success');

      String title = postcustomerModel!.job;
      String body = '$label @ ${userModelOld.name} $label Appointment';

      ProcessSentNotiByToken(
              token: appointmentModel!.tokenSocial, title: title, body: body)
          .sentNoti()
          .then((value) {
        print('Sent Noti Success');
        setState(() {
          showButton = false;
          expMinus = label;
        });
      });
    });
  }
}
