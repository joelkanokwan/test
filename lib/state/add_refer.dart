import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';

class AddReferance extends StatefulWidget {
  const AddReferance({Key? key}) : super(key: key);

  @override
  _AddReferanceState createState() => _AddReferanceState();
}

class _AddReferanceState extends State<AddReferance> {
  File? imageFile;
  List<File?> files = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  Future<Null> chooseSaurceIamge(ImageSource source, int index) async {
    try {
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        imageFile = File(result!.path);
        files[index] = imageFile;
      });
    } catch (e) {}
  }

  Container buildImage() {
    return Container(
      child: Column(
        children: [
          Container(
              width: 250,
              child: imageFile == null ? ShowImage() : Image.file(imageFile!)),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              files[0] == null
                  ? IconButton(
                      icon: Icon(Icons.filter_1),
                      onPressed: () =>
                          chooseSaurceIamge(ImageSource.gallery, 0),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        onLongPress: () =>
                            chooseSaurceIamge(ImageSource.gallery, 0),
                        onTap: () {
                          setState(() {
                            imageFile = files[0];
                          });
                        },
                        child: Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              files[1] == null
                  ? IconButton(
                      icon: Icon(Icons.filter_2),
                      onPressed: () =>
                          chooseSaurceIamge(ImageSource.gallery, 1),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                          onLongPress: () =>
                              chooseSaurceIamge(ImageSource.gallery, 1),
                          onTap: () {
                            setState(() {
                              imageFile = files[1];
                            });
                          },
                          child: Image.file(files[1]!)),
                    ),
              files[2] == null
                  ? IconButton(
                      icon: Icon(Icons.filter_3),
                      onPressed: () =>
                          chooseSaurceIamge(ImageSource.gallery, 2),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                          onLongPress: () =>
                              chooseSaurceIamge(ImageSource.gallery, 2),
                          onTap: () {
                            setState(() {
                              imageFile = files[2];
                            });
                          },
                          child: Image.file(files[2]!)),
                    ),
              files[3] == null
                  ? IconButton(
                      icon: Icon(Icons.filter_4),
                      onPressed: () =>
                          chooseSaurceIamge(ImageSource.gallery, 3),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                          onLongPress: () =>
                              chooseSaurceIamge(ImageSource.gallery, 3),
                          onTap: () {
                            setState(() {
                              imageFile = files[3];
                            });
                          },
                          child: Image.file(files[3]!)),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildImage(),
    );
  }
}
