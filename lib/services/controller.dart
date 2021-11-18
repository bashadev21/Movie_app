import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import 'package:scientisst_db/scientisst_db.dart';

class Controller extends GetxController with BaseController {
  static const BASEURL = 'https://omdbapi.com/';
  static const APIKEY = 'apikey=35882e11';

  var showload = 'no'.obs;
  var showclear = false.obs;
  var searchlist = [].obs;
  var movieDetail = {}.obs;
  var searchstore = ''.obs;
  var genrelist = [].obs;
  var detaillist = [].obs;

  TextEditingController search = new TextEditingController();
  DocumentSnapshot? snap;

  @override
  void onInit() {
    //in first launch i am showing the marvel movies!
    // value after user start search its stores
    detaillist.value = GetStorage().read('detail') ?? [];
    searchmovie(GetStorage().read('lastsearch').toString() == 'null'
        ? 'marvel'
        : GetStorage().read('lastsearch').toString());
    super.onInit();
  }

  void searchmovie(searchval) async {
    showload.value = 'yes';

    var response = await BaseClient()
        .get(BASEURL + '?s=' + searchval + '&' + APIKEY)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    if (data['Response'] == 'True') {
      searchlist.value = data['Search'];
      showload.value = 'no';
    } else {
      searchlist.value = [];
      showload.value = 'no';
    }
  }

  Future<void> moviedetails(id) async {
    showload.value = 'yes';
    var response = await BaseClient()
        .get(BASEURL + '?i=' + id + '&' + APIKEY)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    if (data['Response'] == 'True') {
      showload.value = 'no';

      ///storing values in local DB
      DocumentReference ref =
          await ScientISSTdb.instance.collection('MoviesDb').add(data);
      snap = await ref.get();
      update();

      if (snap!.data['Genre'] != 'N/A') {
        genrelist.value = snap!.data['Genre'].split(',');
        update();
      }
      showload.value = 'no';
    } else {
      movieDetail.value = {};
    }
  }

  checkLocalDb(id) async {
    var values = await ScientISSTdb.instance
        .collection('MoviesDb')
        .where('imdbID', isEqualTo: id)
        .getDocuments();
    if (values.isEmpty) {
      moviedetails(id);
    } else {
      snap = values[0];
      update();
    }
  }
}
