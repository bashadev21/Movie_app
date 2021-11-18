import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp_project/services/controller.dart';
import 'package:movieapp_project/widgets/Text.dart';

import 'package:movieapp_project/widgets/grid_tile.dart';
import 'package:movieapp_project/widgets/header.dart';
import 'package:movieapp_project/widgets/search_bar.dart';
import 'package:sizer/sizer.dart';

class MovieSearch extends StatelessWidget {
  MovieSearch({Key? key}) : super(key: key);
  final Controller con = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0.sp),
          child: SafeArea(
            child: Column(
              children: [
                Header(),
                Obx(() => SearchBar(
                      con: con.search,
                      hint: 'Search movies',
                      showclear: con.showclear.value,
                      onsubmit: (val) {
                        con.searchmovie(val);

                        ///for storing last search into the local storage
                        GetStorage().write('lastsearch', val);
                      },
                      onchange: (val) {
                        if (con.search.text.length != 0) {
                          con.showclear.value = true;
                        } else {
                          con.showclear.value = false;
                        }
                      },
                    )),
                SizedBox(
                  height: 24.sp,
                ),
                Expanded(
                    child: Obx(
                  () => con.searchlist.length == 0
                      ? Center(
                          child: Txt(
                            text: 'No Results Found!',
                          ),
                        )
                      : con.showload.value == 'yes'
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              itemCount: con.searchlist.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio:
                                          (itemWidth / itemHeight),
                                      mainAxisSpacing: 35,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return CGridTile(
                                    griddata: con.searchlist[index]);
                              }),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
