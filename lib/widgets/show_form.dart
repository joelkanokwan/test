import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowForm extends StatelessWidget {
  final String label;
  const ShowForm({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
