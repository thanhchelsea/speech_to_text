import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_code/speech_to_text_ui.dart';

import 'speech_controller.dart';

void main() {
  ScreenUtil.init(
    BoxConstraints(maxWidth: Get.width, maxHeight: Get.height),
    designSize: Size(360, 690),
    minTextAdapt: true,
    orientation: Orientation.portrait,
  );
  runApp(new MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(maxWidth: Get.width, maxHeight: Get.height),
      designSize: Size(360, 690),
      minTextAdapt: true,
      orientation: Orientation.portrait,
    );
    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => SpeechToTextUI(),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
