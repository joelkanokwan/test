import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joelfindtechnician/customer_state/login_page.dart';
import 'package:joelfindtechnician/models/user_model.dart';
import 'package:joelfindtechnician/partner_state/social_service.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';

class AdminService extends StatefulWidget {
  const AdminService({Key? key}) : super(key: key);

  @override
  _AdminServiceState createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> with SingleTickerProviderStateMixin {
  TabController? _tabProvinceApprovecontroller;

  @override
  void dispose() {
    super.dispose();
    _tabProvinceApprovecontroller!.dispose();
  }

  List<UserModelFirebase> userModels = [];
  List<UserModelFirebase> serachUserModels = [];
  List<String> docsIds = [];
  final debouncer = Debouncer(millisecond: 500);

  @override
  void initState() {
    super.initState();
    readAllUser();
    _tabProvinceApprovecontroller = TabController(length: 3, vsync: this);
  }

  Future<Null> readAllUser() async {
    if (userModels.length != 0) {
      userModels.clear();
      docsIds.clear();
      serachUserModels.clear();
    }

    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .orderBy('accept')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          UserModelFirebase userModelFirebase =
              UserModelFirebase.fromMap(item.data());
          setState(() {
            userModels.add(userModelFirebase);
            serachUserModels = userModels;
            docsIds.add(item.id);
          });
        }
      });
    });
  }

  Future<Null> confirmAcceptDialog(
      String docs, UserModelFirebase userModelFirebase) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          title: Text(userModelFirebase.name),
          subtitle: Text(userModelFirebase.email),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('JobType => ${userModelFirebase.jobType}'),
            Text('JobType => ${userModelFirebase.jobScope}'),
            Text('JobType => ${userModelFirebase.phoneNumber}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              editAccept(docs, userModelFirebase);
            },
            child: Text('Accept'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            title: Text(
              'Approve',
            ),
            bottom: TabBar(controller: _tabProvinceApprovecontroller, tabs: [
              Tab(
                text: 'เชียงใหม่',
              ),
              Tab(
                text: 'กรุงเทพมหานคร',
              ),
              Tab(
                text: 'ชลบุรี',
              ),
            ]),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    SocialService().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  icon: Icon(
                    Icons.power_settings_new,
                  ),
                ),
              ),
            ]),
        body: userModels.length == 0
            ? ShowProgress()
            : GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSearch(),
                      buildListView(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Container buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Icon(Icons.search),
              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  serachUserModels = userModels
                      .where((element) => (element.name
                          .toLowerCase()
                          .contains(value.toLowerCase())))
                      .toList();
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Your Name',
              ),
            ),
          ),
        ],
      ),
      // margin: EdgeInsets.all(16),
      // child: TextFormField(
      // onChanged: (value) {
      // setState(() {
      // serachUserModels = userModels
      // .where((element) =>
      // (element.name.toLowerCase().contains(value.toLowerCase())))
      // .toList();
      // });
      // },
      // decoration: InputDecoration(
      // prefix: Icon(Icons.search),
      // border: OutlineInputBorder(),
      // ),
      // ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: serachUserModels.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(serachUserModels[index].name),
                  Checkbox(
                      value: serachUserModels[index].accept,
                      onChanged: (value) {
                        print('You Tap ==> idDoc ==> ${docsIds[index]}');
                        confirmAcceptDialog(
                            docsIds[index], serachUserModels[index]);
                      }),
                ],
              ),
              Text(serachUserModels[index].email),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> editAccept(
      String docs, UserModelFirebase userModelFirebase) async {
    await Firebase.initializeApp().then((value) async {
      Map<String, dynamic> data = {};
      data['accept'] = userModelFirebase.accept;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(docs)
          .update(data)
          .then(
            (value) => readAllUser(),
          );
    });
  }
}

class Debouncer {
  final int millisecond;
  Timer? timer;
  VoidCallback? callback;

  Debouncer({required this.millisecond});

  run(VoidCallback voidCallback) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: millisecond), voidCallback);
  }
}
