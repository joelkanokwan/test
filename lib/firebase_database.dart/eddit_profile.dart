import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/state/home_page.dart';

class EdditProfile extends StatefulWidget {
  const EdditProfile({Key? key}) : super(key: key);

  @override
  _EdditProfileState createState() => _EdditProfileState();
}

class _EdditProfileState extends State<EdditProfile> {
  File? _pickedImage;

  void _imageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _imageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(_pickedImage!),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
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
                          onPressed: () {},
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
