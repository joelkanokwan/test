import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:joelfindtechnician/alertdialog/my_dialog.dart';
import 'package:joelfindtechnician/customer_state/create_post.dart';
import 'package:joelfindtechnician/customer_state/ctm_aboutus.dart';
import 'package:joelfindtechnician/customer_state/ctm_contactus.dart';
import 'package:joelfindtechnician/customer_state/ctm_howtouseapp.dart';
import 'package:joelfindtechnician/customer_state/ctm_notification.dart';
import 'package:joelfindtechnician/customer_state/ctm_ordethistory.dart';
import 'package:joelfindtechnician/customer_state/ctm_termandconditon.dart';
import 'package:joelfindtechnician/models/postcustomer_model.dart';
import 'package:joelfindtechnician/models/replypost_model.dart';
import 'package:joelfindtechnician/models/typetechnic_array.dart';

import 'package:joelfindtechnician/state/list_technic_where_type.dart';
import 'package:joelfindtechnician/state/login_page.dart';
import 'package:joelfindtechnician/customer_state/login_success.dart';
import 'package:joelfindtechnician/customer_state/social_service.dart';
import 'package:joelfindtechnician/models/user_model_old.dart';
import 'package:joelfindtechnician/state/show_image_post.dart';
import 'package:joelfindtechnician/utility/find_user_by_uid.dart';
import 'package:joelfindtechnician/utility/my_constant.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';
import 'package:joelfindtechnician/widgets/show_text.dart';

class CommunityPage extends StatefulWidget {
  final bool? userSocialbol;
  const CommunityPage({Key? key, this.userSocialbol}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final User = FirebaseAuth.instance.currentUser!;
  UserModelOld? userModelOld;
  bool load = true;
  File? image;

  List<String> provinces = MyConstant.provinces;

  String? provinceChoosed;
  List<String> serviceGroups = [];
  List<String> paths = MyConstant.pathImageIcons;
  List<Color> colors = MyConstant.colors;
  List<PostCustomerModel> postCustomerModels = [];
  bool loadPost = true;
  bool? userSocial;
  List<String> docIdPostCustomers = [];

  _imageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  _imageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  @override
  void initState() {
    super.initState();

    userSocial = widget.userSocialbol;
    if (userSocial == null) {
      userSocial = false;
    }

    if (!userSocial!) {
      readUserProfile();
    }

    if (User.displayName != null) {
      load = false;
    }

    findServiceGroup();
  }

  Future<void> findServiceGroup() async {
    if (serviceGroups.isNotEmpty) {
      serviceGroups.clear();
    }

    if (provinceChoosed == null) {
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance.collection('user').get().then((value) {
          for (var item in value.docs) {
            TypeTechnicArrayModel typeTechnicArrayModel =
                TypeTechnicArrayModel.fromMap(item.data());

            if (serviceGroups.isEmpty) {
              List<String> strings = typeTechnicArrayModel.typeTechnics;
              for (var item in strings) {
                setState(() {
                  serviceGroups.add(item);
                });
              }
            } else {
              if (checkGroup(typeTechnicArrayModel.typeTechnics)) {
                List<String> strings = typeTechnicArrayModel.typeTechnics;
                for (var item in strings) {
                  setState(() {
                    serviceGroups.add(item);
                  });
                }
              }
            }
          }
          print('## serviceProvince ==> $serviceGroups');
        });
      });
    } else {
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('user')
            .where('province', isEqualTo: provinceChoosed)
            .get()
            .then((value) {
          for (var item in value.docs) {
            TypeTechnicArrayModel typeTechnicArrayModel =
                TypeTechnicArrayModel.fromMap(item.data());

            if (serviceGroups.isEmpty) {
              List<String> strings = typeTechnicArrayModel.typeTechnics;
              for (var item in strings) {
                setState(() {
                  serviceGroups.add(item);
                });
              }
            } else {
              if (checkGroup(typeTechnicArrayModel.typeTechnics)) {
                List<String> strings = typeTechnicArrayModel.typeTechnics;
                for (var item in strings) {
                  setState(() {
                    serviceGroups.add(item);
                  });
                }
              }
            }
          }
          print('## serviceProvince ==> $serviceGroups');
        });
      });
    }
  }

  bool checkGroup(List<String> typeTechnics) {
    bool result = true;
    for (var item1 in typeTechnics) {
      for (var item2 in serviceGroups) {
        if (item1 == item2) {
          result = false;
        }
      }
    }
    return result;
  }

  Future<void> readUserProfile() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .where('uid', isEqualTo: User.uid)
          .get()
          .then((value) async {
        for (var item in value.docs) {
          String docId = item.id;
          await FirebaseFirestore.instance
              .collection('user')
              .doc(docId)
              .get()
              .then((value) {
            setState(() {
              load = false;
              userModelOld = UserModelOld.fromMap(value.data()!);
              print('## name user login = ${userModelOld!.name}');
            });
          });
        }
      });
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
        title: Text('Community Page'),
      ),
      floatingActionButton: provinceChoosed == null
          ? SizedBox()
          : userSocial!
              ? buildFloating(context)
              : SizedBox(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  dropdownProvince(),
                  buildBanner(),
                  buildTitle(),
                  serviceGroups.isEmpty
                      ? ShowProgress()
                      : gridViewTypeTechnic(),
                  provinceChoosed == null ? SizedBox() : listPost(),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: load ? Drawer() : buildDrawer(context),
    );
  }

  Widget listPost() => loadPost
      ? ShowProgress()
      : Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  Row(
                    children: [
                      ShowText(
                        title: 'List Post',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: postCustomerModels.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(postCustomerModels[index].pathUrl),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShowText(
                            title: protectWord(postCustomerModels[index].name),
                            textStyle: MyConstant().h2Style(),
                          ),
                          ShowText(
                            title: showData(postCustomerModels[index].timePost),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShowText(
                      title: cutWord(postCustomerModels[index].job),
                    ),
                  ),
                  showGridImage(postCustomerModels[index].pathImages),
                  Divider(thickness: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      ShowText(title: postCustomerModels[index].district),
                      SizedBox(width: 8),
                      Icon(Icons.location_on),
                      ShowText(title: postCustomerModels[index].amphur),
                      SizedBox(width: 8),
                      Icon(Icons.location_on),
                      ShowText(title: postCustomerModels[index].province),
                    ],
                  ),
                  Divider(thickness: 2),
                  buildReplyPost(index),
                  Divider(thickness: 2),
                ],
              ),
            ),
          ],
        );

  TextEditingController replyController = TextEditingController();

  Widget buildReplyPost(int index) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userModelOld!.img),
          ),
        ),
        Container(
          width: 250,
          height: 80,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: TextFormField(
              controller: replyController,
              onFieldSubmitted: (value) async {
                await processAddReply(index);
              },
              decoration: InputDecoration(
                suffix: IconButton(
                  onPressed: () async {
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            await processAddReply(index);
          },
          icon: Icon(Icons.send_outlined),
        ),
      ],
    );
  }

  Future<void> processAddReply(int index) async {
    String reply = replyController.text;
    print('## reply = $reply');
    DateTime dateTime = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(dateTime);
    String name = userModelOld!.name;
    String pathImage = userModelOld!.img;
    String uid = userModelOld!.uid;
    ReplyPostModel replyPostModel = ReplyPostModel(
        name: name,
        pathImage: pathImage,
        reply: reply,
        timeReply: timestamp,
        uid: uid);
    await FirebaseFirestore.instance
        .collection('postcustomer')
        .doc(docIdPostCustomers[index])
        .collection('replypost')
        .doc()
        .set(replyPostModel.toMap())
        .then((value) {
      replyController.text = '';
    });
  }

  Widget showGridImage(List<String> pathImages) {
    return pathImages.isEmpty
        ? SizedBox()
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200),
            itemBuilder: (context, index) => Container(
              width: 150,
              height: 150,
              child: InkWell(
                onTap: () {
                  print('## ${pathImages[index]}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowImagePost(pathImage: pathImages[index])));
                },
                child: CachedNetworkImage(
                  imageUrl: pathImages[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ShowProgress(),
                  errorWidget: (context, url, error) => ShowImage(),
                ),
              ),
            ),
            itemCount: pathImages.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
          );
  }

  UserModelOld? MyUserModelOld;

  Future<void> findUserLogin(String uid) async {
    await FirebaseFirestore.instance
        .collection('user')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      for (var item in value.docs) {
        setState(() {
          MyUserModelOld = UserModelOld.fromMap(item.data());
        });
      }
    });
  }

  GridView gridViewTypeTechnic() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: serviceGroups.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          if (provinceChoosed == null) {
            MyDialog().normalDialog(
                context, 'Non Province', 'Please Choose Province');
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListTechnicWhereType(
                      province: provinceChoosed!,
                      typeTechnic: serviceGroups[index]),
                ));
          }
        },
        child: Card(
            color: colors[index],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  child: ShowImage(
                    path: paths[index],
                  ),
                ),
                ShowText(
                  title: serviceGroups[index],
                  textStyle: MyConstant().h2Style(),
                ),
              ],
            )),
      ),
    );
  }

  FloatingActionButton buildFloating(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePost(province: provinceChoosed!),
          ),
        );
      },
      child: Icon(
        Icons.edit_rounded,
      ),
    );
  }

  Container serviceGridView() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          Card(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/aircon.png', color: Colors.blue),
                  Text(
                    'Airconditioner',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Installing Airconditioner'),
                  Text('and fixing accessary')
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.amberAccent,
          ),
          Card(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/electricity.png',
                  ),
                  Text(
                    'Electricity',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Design Installing and fixing'),
                  Text('electricity systems'),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.redAccent,
          ),
          Card(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/toilet.png',
                  ),
                  Text(
                    'Plumbling',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Design Installing and fixing'),
                  Text('asseecsary of toilet'),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Our Services',
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  CarouselSlider buildBanner() {
    return CarouselSlider(
      items: [0, 1, 2, 3].map((item) {
        return Image.asset(
          'assets/images/display_login.jpg',
          fit: BoxFit.cover,
          width: 300,
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2,
      ),
    );
  }

  Container dropdownProvince() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: DropdownButton(
        value: provinceChoosed,
        hint: Text(
          'Please Choose your area',
        ),
        onChanged: (value) {
          docIdPostCustomers.clear();
          postCustomerModels.clear();
          loadPost = true;

          setState(() {
            provinceChoosed = value.toString();
            findServiceGroup();
          });

          readPostCustomerData();
        },
        items: provinces
            .map(
              (e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginSuccess(),
                    ),
                    (route) => false);
              },
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(User.photoURL == null
                            ? userModelOld!.img.isEmpty
                                ? MyConstant.urlNoAvatar
                                : userModelOld!.img
                            : User.photoURL!)),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          User.displayName == null
                              ? userModelOld!.name
                              : User.displayName!,
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          User.email!,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.notification_important_outlined,
                ),
                title: Text('Notification'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerNotification()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.shopping_bag_outlined,
                ),
                title: Text('Order History'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerOrderHistory()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(Icons.person_pin_circle_sharp),
                title: Text('About Us'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerAboutUs()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.message_outlined,
                ),
                title: Text(
                  'Contact Us',
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerContactUs()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.label_important_outlined,
                ),
                title: Text('How to use App'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerHowtouseApp()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.warning_amber_outlined,
                ),
                title: Text('Term and Conditon'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerTermandConditon()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.power_settings_new,
                ),
                title: Text('SignOut'),
                onTap: () {
                  SocialService().signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> readPostCustomerData() async {
    await FirebaseFirestore.instance
        .collection('postcustomer')
        .where('province', isEqualTo: provinceChoosed)
        // .orderBy('timePost')
        .get()
        .then((value) {
      for (var item in value.docs) {
        docIdPostCustomers.add(item.id);

        PostCustomerModel postCustomerModel =
            PostCustomerModel.fromMap(item.data());
        setState(() {
          loadPost = false;
          postCustomerModels.add(postCustomerModel);
        });
      }
    });
  }

  String protectWord(String name) {
    String result = name;
    // result = result.substring(0, 3);
    // result = '$result xxxxx';
    return result;
  }

  String cutWord(String string) {
    String result = string;
    // if (result.length > 150) {
    // result = result.substring(0, 150);
    // result = '$result ...';
    // }

    return result;
  }

  String showData(Timestamp timePost) {
    String result;

    DateTime dateTime = timePost.toDate();
    DateFormat dateFormt = DateFormat('dd MMM yyyy    HH:mm');
    result = dateFormt.format(dateTime);

    return result;
  }
}
