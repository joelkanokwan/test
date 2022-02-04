import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final Function(String?) changeFunc;
  const ShowForm({
    Key? key,
    required this.label,
    required this.changeFunc,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: changeFunc,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          label: Text(
           label,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          )),
    );
  }
}
