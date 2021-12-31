import 'package:flutter_clock/bindinds/home_binding.dart';
import 'package:flutter_clock/view/home_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
