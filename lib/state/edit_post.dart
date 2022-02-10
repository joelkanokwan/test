import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';
import 'package:joelfindtechnician/widgets/show_text.dart';

class EditPost extends StatefulWidget {
  final String docId;
  const EditPost({Key? key, required this.docId}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String? docId;
  PostCustomerModel? postCustomerModel;
  TextEditingController jobController = TextEditingController();
  File? file;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    docId = widget.docId;
    // print('### docId at EditPost ==> $docId');
    readDataPost();
  }

  Future<void> readDataPost() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('postcustomer')
          .doc(docId)
          .get()
          .then((value) {
        setState(() {
          postCustomerModel = PostCustomerModel.fromMap(value.data()!);
          jobController.text = postCustomerModel!.job;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: postCustomerModel == null
          ? ShowProgress()
          : GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        buildTitle(),
                        buildJob(),
                        buttonUpdateJob(),
                        buildHead(),
                        listImage(),
                        postCustomerModel!.pathImages.length != 6
                            ? buttonAddMoreImage()
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  ElevatedButton buttonUpdateJob() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Map<String, dynamic> map = {};
          map['job'] = jobController.text;

          await Firebase.initializeApp().then((value) async {
            await FirebaseFirestore.instance
                .collection('postcustomer')
                .doc(docId)
                .update(map)
                .then((value) => Navigator.pop(context));
          });
        }
      },
      child: Text(
        'Update Job',
      ),
    );
  }

  Future<void> processTakePhoto(ImageSource source, {int? indexEdit}) async {
    try {
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);
      file = File(result!.path);
      String nameFile =
          '${postCustomerModel!.uidCustomer}${Random().nextInt(1000000)}.jpg';
      await Firebase.initializeApp().then((value) async {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference reference = storage.ref().child('customerpost/$nameFile');
        UploadTask task = reference.putFile(file!);
        await task.whenComplete(() async {
          await reference.getDownloadURL().then((value) async {
            String pathImageAdd = value.toString();
            print('### pathImageAdd = $pathImageAdd');
            List<String> pathImges = postCustomerModel!.pathImages;

            if (indexEdit == null) {
              pathImges.add(pathImageAdd);
            } else {
              pathImges[indexEdit] = pathImageAdd;
            }

            Map<String, dynamic> map = {};
            map['pathImages'] = pathImges;
            await FirebaseFirestore.instance
                .collection('postcustomer')
                .doc(docId)
                .update(map)
                .then((value) {
              readDataPost();
            });
          });
        });
      });
    } catch (e) {}
  }

  ElevatedButton buttonAddMoreImage() {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: ListTile(
              leading: ShowImage(),
              title: ShowText(
                title: 'เพิ่มรูปภาพ',
              ),
              subtitle: ShowText(
                title: 'Please Choose Source',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  processTakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Text('camera'),
              ),
              TextButton(
                onPressed: () {
                  processTakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              ),
            ],
          ),
        );
      },
      child: Text(
        'Add More Image',
      ),
    );
  }

  Widget listImage() => postCustomerModel!.pathImages.isEmpty
      ? Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            child: ShowText(
              title: 'ไม่มีรูปภาพ',
            ),
          ),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: postCustomerModel!.pathImages.length,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: ListTile(
                        leading: ShowImage(),
                        title: ShowText(
                          title: 'แก้ไขรูปภาพ',
                        ),
                        subtitle: ShowText(
                          title: 'Please Choose Source',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            processTakePhoto(ImageSource.camera,
                                indexEdit: index);
                            Navigator.pop(context);
                          },
                          child: Text('camera'),
                        ),
                        TextButton(
                          onPressed: () {
                            processTakePhoto(ImageSource.gallery,
                                indexEdit: index);
                            Navigator.pop(context);
                          },
                          child: Text('Gallery'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('cancel'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                width: 200,
                height: 150,
                child: CachedNetworkImage(
                    errorWidget: (context, url, error) => ShowImage(),
                    placeholder: (context, url) => ShowProgress(),
                    imageUrl: postCustomerModel!.pathImages[index]),
              ),
              IconButton(
                onPressed: () async {
                  print('### delete at index ==> $index');
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: ListTile(
                        leading: ShowImage(),
                        title: ShowText(
                          title: 'Confirm Delete',
                        ),
                      ),
                      content: Container(
                        width: 250,
                        height: 200,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => ShowProgress(),
                          imageUrl: postCustomerModel!.pathImages[index],
                          errorWidget: (context, url, error) => ShowImage(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            List<String> strings =
                                postCustomerModel!.pathImages;
                            strings.removeAt(index);
                            Map<String, dynamic> map = {};
                            map['pathImages'] = strings;
                            await Firebase.initializeApp().then((value) async {
                              await FirebaseFirestore.instance
                                  .collection('postcustomer')
                                  .doc(docId)
                                  .update(map)
                                  .then((value) => readDataPost());
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
        );

  Row buildHead() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShowText(
            title: 'Picture :',
          ),
        ),
      ],
    );
  }

  Container buildJob() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกข้อความด้วย';
          } else {
            return null;
          }
        },
        controller: jobController,
        maxLines: 3,
        decoration: InputDecoration(
          label: ShowText(
            title: 'job',
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowText(
          title:
              '${postCustomerModel!.province},${postCustomerModel!.amphur},${postCustomerModel!.district},'),
    );
  }
}
