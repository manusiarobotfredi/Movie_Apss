import 'package:MyMovie/screen/screen_detail_list.dart';
import 'package:MyMovie/screen/screen_homepage.dart';
import 'package:MyMovie/screen/screen_profile.dart';
import 'package:get/get.dart';
import 'package:MyMovie/screen/screen_splash.dart';
import 'package:MyMovie/widget/bottomNavbar.dart';

appRoutes() => [
      GetPage(
        name: '/splash',
        page: () => const ScreenSplash(),
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/main',
        page: () => const BottomNavbar(),
        middlewares: [MyMiddelware()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/homepage',
        page: () => const ScreenHomepage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/detail_list',
        page: () => const ScreenDetailList(),

        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/profile',
        page: () => const ScreenProfile(),

        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
