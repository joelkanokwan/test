import 'package:flutter/material.dart';

class ShowText extends StatelessWidget {
  final String title;
  const ShowText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
