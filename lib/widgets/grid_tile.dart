import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp_project/screens/movie_details.dart';
import 'package:movieapp_project/services/controller.dart';

import 'Text.dart';

class CGridTile extends StatelessWidget {
  final griddata;

  CGridTile({Key? key, this.griddata}) : super(key: key);
  final Controller con = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // con.moviedetails(griddata['imdbID']);
            con.checkLocalDb(griddata['imdbID']);
            Get.to(() => MovieDetails(
                  imgurl: griddata['Poster'],
                ));
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: griddata['Poster'] != "N/A"
                            ? CachedNetworkImage(
                                imageUrl: griddata['Poster'],
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            : Container(
                                child: Center(
                                    child: Text(
                                  'No Image',
                                )),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.32),
                                ),
                              ),
                      )),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
                  child: Txt(
                    text: griddata['Title'],
                    fsize: 9,
                    weight: FontWeight.w500,
                    lines: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Txt(
                    text: griddata['Year'],
                    fsize: 8,
                    color: Get.theme.primaryColor,
                    weight: FontWeight.bold,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
