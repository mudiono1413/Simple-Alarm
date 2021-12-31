import 'package:flutter/material.dart';
import 'package:flutter_clock/routes/app_pages.dart';
import 'package:flutter_clock/utils/my_notification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Alarm',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          fontFamily: 'Nunito',
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
