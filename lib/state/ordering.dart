import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/customer_state/login_page.dart';
import 'package:joelfindtechnician/partner_state/social_service.dart';

class Ordering extends StatefulWidget {
  const Ordering({Key? key}) : super(key: key);

  @override
  _OrderingState createState() => _OrderingState();
}

class _OrderingState extends State<Ordering>
    with SingleTickerProviderStateMixin {
  TabController? _tabProvinceOrderingcontroller;
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
          title: Text('Ordering'),
          bottom: TabBar(controller: _tabProvinceOrderingcontroller, tabs: [
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
          ],
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.search),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Order Number',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView(
                        padding: const EdgeInsets.all(8.0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Customer',
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '#Order Number#',
                                      ),
                                      Text(
                                        'Technician',
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.orange,
                                    size: 23,
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.orange,
                                    size: 23,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
