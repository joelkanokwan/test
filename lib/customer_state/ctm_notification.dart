import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';
import 'package:joelfindtechnician/state/ctm_list_answer.dart';
import 'package:joelfindtechnician/utility/time_to_string.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';
import 'package:joelfindtechnician/widgets/show_text.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({Key? key}) : super(key: key);

  @override
  _CustomerNotificationState createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
  var postCustomerModels = <PostCustomerModel>[];

  String? uidLogin;

  var docIdPostCustomers = <String>[];

  bool load = true;
  bool? haveData;

  var socialReadeds = <bool>[];

  @override
  void initState() {
    super.initState();
    readPostCustomer();
  }

  Future<void> readPostCustomer() async {
    if (postCustomerModels.isNotEmpty) {
      postCustomerModels.clear();
      docIdPostCustomers.clear();
      socialReadeds.clear();
    }
    await Firebase.initializeApp().then((value) async {
      final User = FirebaseAuth.instance.currentUser!;
      uidLogin = User.uid;

      print('#6jan uidLogin ==> $uidLogin');

      await FirebaseFirestore.instance
          .collection('postcustomer')
          .orderBy('timePost', descending: true)
          .get()
          .then((value) async {
        for (var item in value.docs) {
          PostCustomerModel postCustomerModel =
              PostCustomerModel.fromMap(item.data());
          if (postCustomerModel.uidCustomer == uidLogin) {
            load = false;
            String docIdPostCustomer = item.id;

            await FirebaseFirestore.instance
                .collection('postcustomer')
                .doc(docIdPostCustomer)
                .collection('replypost')
                .get()
                .then((value) {
              if (value.docs.isNotEmpty) {
                setState(() {
                  haveData = true;
                  postCustomerModels.add(postCustomerModel);
                  docIdPostCustomers.add(docIdPostCustomer);
                  socialReadeds.add(postCustomerModel.socialReaded);
                });
              } else {
                haveData = false;
              }
            });
          } // if
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: newAppBar(context),
      body: load
          ? ShowProgress()
          : haveData!
              ? ListView.builder(
                  itemCount: postCustomerModels.length,
                  itemBuilder: (context, index) => newContent(
                    postCustomerModels[index].job,
                    TimeToString(timestamp: postCustomerModels[index].timePost)
                        .findString(),
                    postCustomerModels[index],
                    index,
                  ),
                )
              : Center(child: ShowText(title: 'No Message')),
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
      title: Text('Customer Notification'),
    );
  }

  Widget newContent(
    String job,
    String timePost,
    PostCustomerModel postCustomerModel,
    int index,
  ) {
    return InkWell(
      onTap: () async {
        String docIdPostCustomer = docIdPostCustomers[index];
        print('##23jan docIdPostCustomer ==>> $docIdPostCustomer');
        bool socialReaded = postCustomerModels[index].socialReaded;
        print('##23jan socialReaded ==> $socialReaded');
        if (!socialReaded) {
          Map<String, dynamic> data = {};
          data['socialReaded'] = true;
          await FirebaseFirestore.instance
              .collection('postcustomer')
              .doc(docIdPostCustomer)
              .update(data)
              .then((value) => print('##23jan Update Success'));
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CtmListAnswer(
              job: job,
              postCustomerModel: postCustomerModel,
            ),
          ),
        ).then((value) => readPostCustomer());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                child: Text(
                  job,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: socialReadeds[index]
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  timePost,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
