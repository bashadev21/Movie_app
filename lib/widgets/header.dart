import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp_project/widgets/Text.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  text: 'Browse',
                  fsize: 25,
                  weight: FontWeight.w500,
                ),
                Txt(
                  text: 'Movies',
                  color: Get.theme.primaryColor,
                  fsize: 12,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                // GetStorage().remove('detail');
                log(GetStorage().read('detail').toString());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 4,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 4,
                    width: 22,
                    decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
