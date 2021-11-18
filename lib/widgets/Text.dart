import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Txt extends StatelessWidget {
  final String text;
  final double fsize;
  final FontWeight weight;
  final int lines;
  final Color color;
  const Txt(
      {Key? key,
      this.text = '',
      this.fsize = 16,
      this.lines = 1000,
      this.color = Colors.white,
      this.weight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: fsize.sp,
              fontWeight: weight,
              color: color,
              height: 1.2,
              letterSpacing: .7)),
    );
  }
}
