import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:joelfindtechnician/models/reference_model.dart';
import 'package:joelfindtechnician/utility/my_constant.dart';
import 'package:photo_view/photo_view.dart';

class ShowPhotoRefer extends StatefulWidget {
  final ReferenceModel referenceModel;
  const ShowPhotoRefer({Key? key, required this.referenceModel})
      : super(key: key);

  @override
  _ShowPhotoReferState createState() => _ShowPhotoReferState();
}

class _ShowPhotoReferState extends State<ShowPhotoRefer> {
  ReferenceModel? referenceModel;

  @override
  void initState() {
    super.initState();
    referenceModel = widget.referenceModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constaints) {
        return Column(children: [
          Container(
            height: constaints.maxHeight - 60,
            child: PhotoView(
              imageProvider: NetworkImage(
                referenceModel!.image,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            width: constaints.maxWidth,
            height: 60,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(changDateToString(referenceModel!.datejob), style: MyConstant().h2StyleWhite(),),
                  Text(referenceModel!.descrip,style: MyConstant().h2StyleWhite()),
                ],
              ),
            ),
          ),
        ]);
      }),
    );
  }

  String changDateToString(Timestamp datejob) {
    String result;

    DateTime dateTime = datejob.toDate();
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    result = dateFormat.format(dateTime);
    return result;
  }
}