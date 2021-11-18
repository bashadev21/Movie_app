import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp_project/services/controller.dart';
import 'package:sizer/sizer.dart';

class SearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController con;
  final bool showclear;

  final ValueChanged onsubmit;
  final ValueChanged onchange;
  SearchBar(
      {Key? key,
      this.hint = '',
      required this.showclear,
      required this.onsubmit,
      required this.con,
      required this.onchange})
      : super(key: key);
  final Controller _con = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(0.32),
      ),
      child: TextField(
        controller: con,
        cursorColor: Get.theme.primaryColor,
        cursorWidth: 2,
        onSubmitted: onsubmit,
        onChanged: onchange,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 12.sp, color: Colors.white, letterSpacing: .8)),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Get.theme.primaryColor),
          hintText: hint,
          suffixIcon: showclear
              ? InkWell(
                  onTap: () {
                    con.clear();
                    _con.showclear.value = false;
                  },
                  child: Icon(Icons.cancel, color: Get.theme.primaryColor))
              : SizedBox(),
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Get.theme.primaryColor,
                  letterSpacing: .8)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(11.sp),
        ),
      ),
    );
  }
}
