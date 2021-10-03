import 'package:flutter/material.dart';

class MyReferance extends StatefulWidget {
  const MyReferance({Key? key}) : super(key: key);

  @override
  _MyReferanceState createState() => _MyReferanceState();
}

class _MyReferanceState extends State<MyReferance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Referance'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addReferance'),
      ),
    );
  }
}
