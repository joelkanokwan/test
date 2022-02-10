import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/models/answer_model.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';
import 'package:joelfindtechnician/models/replypost_model.dart';
import 'package:joelfindtechnician/models/token_model.dart';

import 'package:joelfindtechnician/state/show_circleavatar.dart';
import 'package:joelfindtechnician/state/show_general_profile.dart';
import 'package:joelfindtechnician/state/show_image_post.dart';

import 'package:joelfindtechnician/utility/time_to_string.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';
import 'package:joelfindtechnician/widgets/show_image_network.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';
import 'package:joelfindtechnician/widgets/show_text.dart';

class CtmListAnswer extends StatefulWidget {
  final String? job;
  final PostCustomerModel postCustomerModel;

  const CtmListAnswer({
    Key? key,
    this.job,
    required this.postCustomerModel,
  }) : super(key: key);

  @override
  State<CtmListAnswer> createState() => _CtmListAnswerState();
}

class _CtmListAnswerState extends State<CtmListAnswer> {
  String? job;
  bool load = true;
  var replyPostModels = <ReplyPostModel>[];
  PostCustomerModel? postCustomerModel;
  var showTextFormAnswers = <bool>[];
  var answers = <String>[];
  List files = <File?>[];
  String? namePost, urlPost;

  String? docIdPostCustomer;
  var docIdReplyPosts = <String>[];

  var showListAnswers = <bool>[];
  List<List<AnswerModel>> listAnswerModels = [];

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // job = widget.job;
    postCustomerModel = widget.postCustomerModel;
    job = postCustomerModel!.job;
    print('#1feb job ที่ส่งมาจาก ctm_notification ==>> $job');

    readReplyPost();
    findUserLogin();
    findDocIdPostCustomer();
  }

  Future<void> findDocIdPostCustomer() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('postcustomer')
          .where('job', isEqualTo: job)
          .get()
          .then((value) {
        for (var item in value.docs) {
          docIdPostCustomer = item.id;
        }
      });
    });
  }

  Future<void> findUserLogin() async {
    await Firebase.initializeApp().then((value) async {
      final User = FirebaseAuth.instance.currentUser!;
      String uidLogin = User.uid;
      print('#12jan uidLogin ==> $uidLogin');

      namePost = User.displayName;
      urlPost = User.photoURL;
    });
  }

  Future<void> readReplyPost() async {
    if (replyPostModels.isNotEmpty) {
      replyPostModels.clear();
      showTextFormAnswers.clear();
      answers.clear();
      files.clear();
      docIdReplyPosts.clear();
      showListAnswers.clear();
      listAnswerModels.clear();
    }

    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('postcustomer')
          .where('job', isEqualTo: job)
          .get()
          .then((value) async {
        for (var item in value.docs) {
          String docIdPostCustomer = item.id;
          print('#12jan docIdPostCustomer ==> $docIdPostCustomer');
          await FirebaseFirestore.instance
              .collection('postcustomer')
              .doc(docIdPostCustomer)
              .collection('replypost')
              .orderBy('timeReply', descending: true)
              .get()
              .then((value) async {
            for (var item in value.docs) {
              String docIdReplypost = item.id;
              ReplyPostModel model = ReplyPostModel.fromMap(item.data());
              showTextFormAnswers.add(false);
              answers.add('');
              files.add(null);
              docIdReplyPosts.add(docIdReplypost);
              var answerModels = <AnswerModel>[];

              await FirebaseFirestore.instance
                  .collection('postcustomer')
                  .doc(docIdPostCustomer)
                  .collection('replypost')
                  .doc(docIdReplypost)
                  .collection('answer')
                  .orderBy('timePost', descending: false)
                  .get()
                  .then((value) {
                print('#13jan value find answerlist ==> ${value.docs}');

                if (value.docs.isEmpty) {
                  showListAnswers.add(false);
                } else {
                  showListAnswers.add(true);

                  for (var item in value.docs) {
                    AnswerModel answerModel = AnswerModel.fromMap(item.data());
                    answerModels.add(answerModel);
                  }
                }
              });

              setState(() {
                replyPostModels.add(model);
                listAnswerModels.add(answerModels);
              });
            }
          });
        }
        setState(() {
          load = false;
        });
      });
    });
  }

  Future<void> processTakePhoto(ImageSource imageSource, int index) async {
    try {
      var result = await ImagePicker()
          .getImage(source: imageSource, maxWidth: 800, maxHeight: 800);
      setState(() {
        files[index] = File(result!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(job!),
        ),
        body: load
            ? ShowProgress()
            : SingleChildScrollView(
                child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(FocusScopeNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newShowOwnerPost(),
                      ShowText(title: postCustomerModel!.job),
                      Divider(thickness: 2),
                      newAddress(),
                      Divider(thickness: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: replyPostModels.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      processMoveGenProfile(
                                        uidAvatar: replyPostModels[index].uid,
                                        postCustomerModel: postCustomerModel!,
                                      );
                                    },
                                    child: ShowCircleAvatar(
                                      url: replyPostModels[index].pathImage,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ShowText(
                                          title: replyPostModels[index].name),
                                      ShowText(
                                          title: TimeToString(
                                                  timestamp:
                                                      replyPostModels[index]
                                                          .timeReply)
                                              .findString()),
                                      ShowText(
                                          title: replyPostModels[index].reply),
                                    ],
                                  ),
                                ],
                              ),
                              replyPostModels[index].urlImagePost.isEmpty
                                  ? SizedBox()
                                  : Container(
                                      width: 160,
                                      height: 140,
                                      child: ShowImageNetWork(
                                        urlPath:
                                            replyPostModels[index].urlImagePost,
                                        tapFunc: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ShowImagePost(
                                                pathImage:
                                                    replyPostModels[index]
                                                        .urlImagePost),
                                          ),
                                        ),
                                      ),
                                    ),
                              showListAnswers[index]
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount:
                                            listAnswerModels[index].length,
                                        itemBuilder: (context, index2) =>
                                            Column(
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () =>
                                                      processMoveGenProfile(
                                                    uidAvatar:
                                                        listAnswerModels[index]
                                                                [index2]
                                                            .uidPost,
                                                    postCustomerModel:
                                                        postCustomerModel!,
                                                  ),
                                                  child: ShowCircleAvatar(
                                                    url: listAnswerModels[index]
                                                            [index2]
                                                        .urlPost,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ShowText(
                                                        title: listAnswerModels[
                                                                index][index2]
                                                            .namePost),
                                                    ShowText(
                                                      title: TimeToString(
                                                              timestamp:
                                                                  listAnswerModels[
                                                                              index]
                                                                          [
                                                                          index2]
                                                                      .timePost)
                                                          .findString(),
                                                    ),
                                                    ShowText(
                                                        title: listAnswerModels[
                                                                index][index2]
                                                            .answer),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            listAnswerModels[index][index2]
                                                    .urlImage
                                                    .isEmpty
                                                ? SizedBox()
                                                : Container(
                                                    width: 200,
                                                    height: 160,
                                                    child: ShowImageNetWork(
                                                      tapFunc: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ShowImagePost(
                                                                        pathImage:
                                                                            listAnswerModels[index][index2].urlImage),
                                                              )),
                                                      urlPath: listAnswerModels[
                                                              index][index2]
                                                          .urlImage,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            showTextFormAnswers[index] =
                                                !showTextFormAnswers[index];
                                          });
                                        },
                                        child: Text('ตอบกลับ'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              showTextFormAnswers[index]
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 40,
                                          child: TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value.trim();
                                              });
                                            },
                                            decoration: InputDecoration(
                                              suffix: IconButton(
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: ListTile(
                                                        leading: ShowImage(),
                                                        title: ShowText(
                                                            title:
                                                                'Choose Source Image'),
                                                        subtitle: ShowText(
                                                            title:
                                                                'Please Click Camera or Gallery'),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            processTakePhoto(
                                                                ImageSource
                                                                    .camera,
                                                                index);
                                                          },
                                                          child: Text('Camera'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            processTakePhoto(
                                                                ImageSource
                                                                    .gallery,
                                                                index);
                                                          },
                                                          child:
                                                              Text('Gallery'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text('Cancel'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                    Icons.add_a_photo_outlined),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ((answers[index].length != 0) ||
                                                (files[index] != null))
                                            ? IconButton(
                                                onPressed: () async {
                                                  if (files[index] == null) {
                                                    processPostAnswer(
                                                        urlImage: '',
                                                        index: index);
                                                  } else {
                                                    await Firebase
                                                            .initializeApp()
                                                        .then((value) async {
                                                      String nameImage =
                                                          'answer${Random().nextInt(10000000)}.jpg';
                                                      FirebaseStorage storage =
                                                          FirebaseStorage
                                                              .instance;
                                                      Reference reference =
                                                          storage.ref().child(
                                                              'answer/$nameImage');
                                                      UploadTask uploadTask =
                                                          reference.putFile(
                                                              files[index]);
                                                      await uploadTask
                                                          .whenComplete(
                                                              () async {
                                                        String urlImage =
                                                            await reference
                                                                .getDownloadURL();
                                                        processPostAnswer(
                                                            urlImage: urlImage,
                                                            index: index);
                                                      });
                                                    });
                                                  }
                                                },
                                                icon: Icon(Icons.send),
                                              )
                                            : SizedBox(),
                                      ],
                                    )
                                  : SizedBox(),
                              files[index] == null
                                  ? SizedBox()
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 16),
                                          width: 200,
                                          height: 200,
                                          child: Image.file(
                                            files[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              files[index] = null;
                                            });
                                          },
                                          icon: Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Row newAddress() {
    return Row(
      children: [
        Icon(Icons.location_on),
        ShowText(title: postCustomerModel!.district),
        SizedBox(width: 8),
        Icon(Icons.location_on),
        ShowText(title: postCustomerModel!.amphur),
        SizedBox(width: 8),
        Icon(Icons.location_on),
        ShowText(title: postCustomerModel!.province),
      ],
    );
  }

  Row newShowOwnerPost() {
    return Row(
      children: [
        ShowCircleAvatar(
          url: postCustomerModel!.pathUrl,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowText(title: postCustomerModel!.name),
            ShowText(
                title: TimeToString(timestamp: postCustomerModel!.timePost)
                    .findString())
          ],
        ),
      ],
    );
  }

  Future<void> processPostAnswer(
      {required String urlImage, required int index}) async {
    print('#12jan urlImage ==>> $urlImage');

    AnswerModel answerModel = AnswerModel(
        answer: answers[index],
        namePost: namePost!,
        urlPost: urlPost!,
        urlImage: urlImage,
        timePost: Timestamp.fromDate(DateTime.now()),
        status: 'online',
        uidPost: user!.uid);

    print('#13jan answerModel ==> ${answerModel.toMap()}');
    print('#13jan docIdPostCustomer ==> $docIdPostCustomer');
    print('#13jan docIdReplyPosts ==>> ${docIdReplyPosts[index]}');

    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('postcustomer')
          .doc(docIdPostCustomer)
          .collection('replypost')
          .doc(docIdReplyPosts[index])
          .collection('answer')
          .doc()
          .set(answerModel.toMap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('postcustomer')
            .doc(docIdPostCustomer)
            .collection('replypost')
            .doc(docIdReplyPosts[index])
            .get()
            .then((value) async {
          ReplyPostModel replyPostModel = ReplyPostModel.fromMap(value.data()!);
          String uidPost = replyPostModel.uid;
          print('#13jan uidPost ==> $uidPost');

          await FirebaseFirestore.instance
              .collection('user')
              .where('uid', isEqualTo: uidPost)
              .get()
              .then((value) async {
            for (var item in value.docs) {
              String docIdUser = item.id;
              print('#13jan docIdUser ==> $docIdUser');
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(docIdUser)
                  .collection('mytoken')
                  .doc('doctoken')
                  .get()
                  .then((value) async {
                TokenModel tokenModel = TokenModel.fromMap(value.data()!);
                String tokenPost = tokenModel.token;
                print('#13jan tokenPost ==>> $tokenPost');
                String title = 'มีการตอบกลับ';
                String body = '$namePost';
                String path =
                    'https://www.androidthai.in.th/eye/apiNotification.php?isAdd=true&token=$tokenPost&title=$title&body=$body';
                await Dio().get(path).then((value) => readReplyPost());
              });
            }
          });
        });
      });
    });
  }

  void processMoveGenProfile(
      {required String uidAvatar,
      required PostCustomerModel postCustomerModel}) {
    print('#1feb uid of Avatar ==> $uidAvatar');
    if (uidAvatar != user!.uid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowGeneralProfile(
            uidTechnic: uidAvatar,
            showContact: true,
            postCustomerModel: postCustomerModel,
            docIdPostCustomer: docIdPostCustomer, // หามาให้ได้
          ),
        ),
      );
    }
  }
}
