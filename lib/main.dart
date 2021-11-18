import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp_project/services/controller.dart';
import 'package:sizer/sizer.dart';

import 'screens/movie_search.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
  Get.put(Controller());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black54));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.cupertino,
        title: 'Movie App',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black54,
            primaryColor: Colors.grey[400]),
        home: MovieSearch(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
