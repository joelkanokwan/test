import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/customer_state/login_page.dart';
import 'package:joelfindtechnician/partner_state/social_service.dart';

class Financial extends StatefulWidget {
  const Financial({Key? key}) : super(key: key);

  @override
  _FinancialState createState() => _FinancialState();
}

class _FinancialState extends State<Financial>
    with SingleTickerProviderStateMixin {
  TabController? _tabProvinceFinancialcontroller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
          title: Text('financial'),
          bottom: TabBar(controller: _tabProvinceFinancialcontroller, tabs: [
            Tab(
              text: 'All',
            ),
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
        body: SafeArea(
          child: TabBarView(
            controller: _tabProvinceFinancialcontroller,
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  ],
                ),
                
              ),

              // Container(
              // margin: EdgeInsetsDirectional.only(top: 20),
              // padding: EdgeInsets.all(30),
              // child: GridView.count(
              // crossAxisCount: 2,
              // children: [
              // Card(
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(20),
              // ),
              // margin: EdgeInsets.all(8),
              // child: InkWell(
              // onTap: () {},
              // child: Center(
              // child: Column(
              // children: [
              // Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: Icon(
              // Icons.money,
              // size: 50,
              // color: Colors.orange,
              // ),
              // ),
              // Text(
              // 'Total Revenue',
              // style: GoogleFonts.lato(
              // fontSize: 20,
              // color: Colors.grey,
              // ),
              // ),
              // ],
              // ),
              // ),
              // ),
              // ),
              // Card(
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(20),
              // ),
              // margin: EdgeInsets.all(8),
              // child: InkWell(
              // onTap: () {},
              // child: Center(
              // child: Column(
              // children: [
              // Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: Icon(
              // Icons.emoji_emotions_outlined,
              // size: 50,
              // color: Colors.orange,
              // ),
              // ),
              // Text(
              // 'Total GP 15%',
              // style: GoogleFonts.lato(
              // fontSize: 20,
              // color: Colors.grey,
              // ),
              // ),
              // ],
              // ),
              // ),
              // ),
              // ),
              // Card(
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(20),
              // ),
              // margin: EdgeInsets.all(8),
              // child: InkWell(
              // onTap: () {},
              // child: Center(
              // child: Column(
              // children: [
              // Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: Icon(
              // Icons.money_off_csred_outlined,
              // size: 50,
              // color: Colors.orange,
              // ),
              // ),
              // Text(
              // 'Service tax 3%',
              // style: GoogleFonts.lato(
              // fontSize: 20,
              // color: Colors.grey,
              // ),
              // ),
              // ],
              // ),
              // ),
              // ),
              // ),
              // Card(
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(20),
              // ),
              // margin: EdgeInsets.all(8),
              // child: InkWell(
              // onTap: () {},
              // child: Center(
              // child: Column(
              // children: [
              // Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: Icon(
              // Icons.money_off,
              // size: 50,
              // color: Colors.orange,
              // ),
              // ),
              // Text(
              // 'Vat 7%',
              // style: GoogleFonts.lato(
              // fontSize: 20,
              // color: Colors.grey,
              // ),
              // ),
              // ],
              // ),
              // ),
              // ),
              // ),
              // Card(
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(20),
              // ),
              // margin: EdgeInsets.all(8),
              // child: InkWell(
              // onTap: () {},
              // child: Center(
              // child: Column(
              // children: [
              // Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: Icon(
              // Icons.badge_outlined,
              // size: 50,
              // color: Colors.orange,
              // ),
              // ),
              // Text(
              // 'Total Allowance',
              // style: GoogleFonts.lato(
              // fontSize: 20,
              // color: Colors.grey,
              // ),
              // ),
              // ],
              // ),
              // ),
              // ),
              // ),
              // ],
              // ),
              // ),
              Container(
                margin: EdgeInsetsDirectional.only(top: 20),
                padding: EdgeInsets.all(30),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total Revenue',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total GP 15%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money_off_csred_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Service tax 3%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money_off,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Vat 7%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.badge_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total Allowance',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: 20),
                padding: EdgeInsets.all(30),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total Revenue',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total GP 15%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money_off_csred_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Service tax 3%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money_off,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Vat 7%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.badge_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total Allowance',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: 20),
                padding: EdgeInsets.all(30),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total Revenue',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total GP 15%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money_off_csred_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Service tax 3%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.money_off,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Vat 7%',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.badge_outlined,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Total Allowance',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
