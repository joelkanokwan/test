import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/alertdialog/choose_jobscope.dart';
import 'package:joelfindtechnician/alertdialog/select_province.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  String? imgUrl;

  TextEditingController addressController = TextEditingController();

  _imageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  _imageFromGallery() async {
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text('Create Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
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
                  },
                );
              },
              icon: Icon(Icons.camera_alt_outlined),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please type job description';
                      } else {}
                    },
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Job Description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill your address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Address",
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
                        'เลือกแท๊กงาน',
                        style: GoogleFonts.lato(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 50,
                    width: 330,
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: Text(
                        'Post',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
