import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/alertdialog/errorupload_profilePic.dart';
import 'package:joelfindtechnician/alertdialog/updateprofile_success.dart';
import 'package:joelfindtechnician/state/home_page.dart';

class EdditProfile extends StatefulWidget {
  const EdditProfile({Key? key}) : super(key: key);

  @override
  _EdditProfileState createState() => _EdditProfileState();
}

class _EdditProfileState extends State<EdditProfile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController img = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController about = TextEditingController();
  File? image;
  String? imgUrl;

  Future<void> uploadDatatoFirestore() async {
    if (formKey.currentState!.validate()) {
      if (image == null) {
        showDialog(
            context: context,
            builder: (context) => ErrorUpLoadProfilePic(
                title: '', discription: '', buttonText: ''));
      }
      Random random = Random();
      int i = random.nextInt(1000000);
      var storageImage =
          FirebaseStorage.instance.ref().child('Images/images$i');
      var task = storageImage.putFile(image!);
      imgUrl = await (await task).ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Product').add(
          {'name': name.text, 'img': imgUrl.toString(), 'about': about.text});
      showDialog(
        context: context,
        builder: (context) =>
            UpdateProfileSuccess(title: '', discription: '', buttonText: ''),
      );

      formKey.currentState!.reset();
    }
  }

  Future<void> _imageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  Future<void> _imageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.blueAccent,
                            backgroundImage:
                                image == null ? null : FileImage(image!),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Name';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Name",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: about,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter About';
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 10,
                              decoration: InputDecoration(
                                labelText: "About",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 50,
                          width: 350,
                          child: FlatButton(
                            color: Colors.blue,
                            onPressed: () {
                              uploadDatatoFirestore();
                            },
                            child: Text(
                              'Save',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 110,
                left: 200,
                child: RawMaterialButton(
                  elevation: 10,
                  fillColor: Colors.blueGrey,
                  child: Icon(Icons.add_a_photo),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                'Choose Profile Photo',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purpleAccent,
                                ),
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton.icon(
                                    onPressed: () {
                                      _imageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.camera,
                                        color: Colors.purpleAccent),
                                    label: Text('Camera'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      _imageFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.purpleAccent,
                                    ),
                                    label: Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
