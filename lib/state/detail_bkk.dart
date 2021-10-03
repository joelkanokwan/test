import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBangkokPage extends StatefulWidget {
  const DetailBangkokPage({Key? key}) : super(key: key);

  @override
  _DetailBangkokPageState createState() => _DetailBangkokPageState();
}

class _DetailBangkokPageState extends State<DetailBangkokPage> {
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
        title: Text('Detail Bangkok Page'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  height: 110,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'Name',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.location_on_outlined,
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                'About',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
