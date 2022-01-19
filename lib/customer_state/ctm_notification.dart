import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/customer_state/ctm_aboutus.dart';
import 'package:joelfindtechnician/customer_state/ctm_contactus.dart';
import 'package:joelfindtechnician/customer_state/ctm_howtouseapp.dart';
import 'package:joelfindtechnician/customer_state/ctm_ordethistory.dart';
import 'package:joelfindtechnician/customer_state/ctm_termandconditon.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';
import 'package:joelfindtechnician/state/ctm_list_answer.dart';
import 'package:joelfindtechnician/state/detail_noti_social.dart';
import 'package:joelfindtechnician/state/login_page.dart';
import 'package:joelfindtechnician/customer_state/login_success.dart';
import 'package:joelfindtechnician/customer_state/social_service.dart';
import 'package:joelfindtechnician/state/community_page.dart';
import 'package:joelfindtechnician/utility/time_to_string.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({Key? key}) : super(key: key);

  @override
  _CustomerNotificationState createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
  var postCustomerModels = <PostCustomerModel>[];

  String? uidLogin;

  var docIdPostCustomers = <String>[];
  @override
  void initState() {
    super.initState();
    readPostCustomer();
  }

  Future<void> readPostCustomer() async {
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
            String docIdPostCustomer = item.id;
            print(
                '#13jan docIdPostCustomer ที่ ctm_notification ==> $docIdPostCustomer');
            await FirebaseFirestore.instance
                .collection('postcustomer')
                .doc(docIdPostCustomer)
                .collection('replypost')
                .get()
                .then((value) {
              if (value.docs.isNotEmpty) {
                setState(() {
                  postCustomerModels.add(postCustomerModel);
                  docIdPostCustomers.add(docIdPostCustomer);
                });
              }
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: newAppBar(context),
      body: postCustomerModels.isEmpty
          ? ShowProgress()
          : ListView.builder(
              itemCount: postCustomerModels.length,
              itemBuilder: (context, index) => newContent(
                postCustomerModels[index].job,
                TimeToString(timestamp: postCustomerModels[index].timePost)
                    .findString(),
                postCustomerModels[index],
                index,
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CtmListAnswer(
              job: job,
              postCustomerModel: postCustomerModel,
            ),
          ),
        );
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
                    fontWeight: FontWeight.bold,
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
