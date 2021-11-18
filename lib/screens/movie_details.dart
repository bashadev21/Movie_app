import 'package:glass/glass.dart';
import 'package:movieapp_project/services/controller.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp_project/widgets/Text.dart';

class MovieDetails extends StatelessWidget {
  final String imgurl;
  MovieDetails({Key? key, this.imgurl = ''}) : super(key: key);
  final Controller con = Get.find();
  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      con.movieDetail.clear();
      return true;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: Get.height * .3,
              child: imgurl == 'N/A'
                  ? Container(
                      child: Center(
                          child: Text(
                        'No Image',
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.32),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: imgurl,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
            Positioned.fill(
                bottom: Get.height * .3,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                        Colors.grey.withOpacity(0.0),
                        Colors.black.withOpacity(0.5),
                      ],
                          stops: [
                        0.0,
                        1.0
                      ])),
                )),
            GetBuilder<Controller>(
              builder: (value) => Positioned.fill(
                left: 20,
                right: 20,
                top: Get.height / 2 - 100,
                child: Container(
                  child: value.showload.value == 'yes'
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Txt(
                                                text: value.snap!.data['Title'],
                                                fsize: 12,
                                                weight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_border_outlined,
                                            color: Get.theme.primaryColor,
                                            size: 14.sp,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Txt(
                                            text: value.snap!.data['imdbRating']
                                                .toString(),
                                            fsize: 12,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.timer,
                                            color: Get.theme.primaryColor,
                                            size: 14.sp,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Txt(
                                            text: value.snap!.data['Runtime']
                                                .toString(),
                                            fsize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Txt(
                                              text: value.snap!.data['Type']
                                                  .toString(),
                                              fsize: 10,
                                              weight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          children: value.genrelist
                                              .map((item) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(999),
                                                        color: Colors.grey
                                                            .withOpacity(0.32),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10),
                                                        child: Center(
                                                          child: Txt(
                                                            text: item,
                                                            fsize: 7,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              .toList()
                                              .cast<Widget>(),
                                        )
                                        // Expanded(
                                        //   child: GridView.builder(
                                        //       physics:
                                        //           NeverScrollableScrollPhysics(),
                                        //       shrinkWrap: true,
                                        //       itemCount: value.genrelist.length,
                                        //       gridDelegate:
                                        //           SliverGridDelegateWithFixedCrossAxisCount(
                                        //               childAspectRatio:
                                        //                   (1 / .4),
                                        //               crossAxisCount: 3),
                                        //       itemBuilder: (context, index) {
                                        //         return Padding(
                                        //           padding:
                                        //               const EdgeInsets.all(8.0),
                                        //           child: Container(
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       999),
                                        //               color: Colors.grey
                                        //                   .withOpacity(0.32),
                                        //             ),
                                        //             child: Padding(
                                        //               padding: const EdgeInsets
                                        //                       .symmetric(
                                        //                   vertical: 5,
                                        //                   horizontal: 10),
                                        //               child: Center(
                                        //                 child: Txt(
                                        //                   text: value
                                        //                       .genrelist[index],
                                        //                   fsize: 7,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         );
                                        //       }),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Container(
                                height: .3,
                                color: Colors.white70,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: ListView(
                                    children: [
                                      if (value.snap!.data['Plot'] != 'N/A')
                                        Txt(
                                          text: value.snap!.data['Plot']
                                              .toString(),
                                          fsize: 10,
                                        ),
                                      if (value.snap!.data['Plot'] != 'N/A')
                                        SizedBox(
                                          height: 20,
                                        ),
                                      if (value.snap!.data['Director'] != 'N/A')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Txt(
                                                  text: 'Director: ',
                                                  fsize: 10,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Txt(
                                                    text: value
                                                        .snap!.data['Director']
                                                        .toString(),
                                                    fsize: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (value.snap!.data['Writer'] != 'N/A')
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Txt(
                                                text: 'Writer: ',
                                                fsize: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          new EdgeInsets.only(
                                                              right: 13.0),
                                                      child: Txt(
                                                        text: value.snap!
                                                            .data['Writer']
                                                            .toString(),
                                                        fsize: 10,
                                                        lines: 4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (value.snap!.data['Actors'] != 'N/A')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Txt(
                                              text: 'Actors: ',
                                              fsize: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            right: 13.0),
                                                    child: Txt(
                                                      text: value
                                                          .snap!.data['Actors']
                                                          .toString(),
                                                      fsize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.5),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0
                                      ]),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.6),
                        ],
                        stops: [
                          0.0,
                          1.0
                        ]),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                ).asGlass(clipBorderRadius: BorderRadius.circular(25)),
              ),
            ),
            Positioned(
                top: 30,
                left: 10,
                child: InkWell(
                    onTap: () {
                      Get.back();

                      con.snap!.data.clear();
                    },
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ))))
          ],
        ),
      ),
    );
  }
}
