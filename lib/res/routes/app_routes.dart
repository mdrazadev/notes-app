import 'package:get/get.dart';
import 'package:notes_app/res/routes/routes_name.dart';
import 'package:notes_app/screens/home/home_binding.dart';
import 'package:notes_app/screens/home/home_v.dart' show HomeV;
import 'package:notes_app/screens/splash/splash_v.dart' show SplashV;

class AppRoutes {
  static List<GetPage<dynamic>> get getRoutes => [
    GetPage(name: RoutesName.splash, page: () => SplashV()),
    GetPage(name: RoutesName.home, page: () => HomeV(), binding: HomeBinding()),
  ];
}
