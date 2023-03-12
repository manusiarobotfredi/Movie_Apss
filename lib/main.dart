import 'package:alice/alice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:MyMovie/controller/notificationController.dart';
import 'package:MyMovie/locator.dart';
import 'package:MyMovie/routes/routes.dart';
import 'package:MyMovie/service/service_API.dart';
import 'package:MyMovie/service/service_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MyMovie/service/service_notif.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = true;

  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();

  // setupLocator();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Alice alice = Alice(showNotification: !kDebugMode ? false : true);
    CallApi.initialize(alice);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        title: '',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        initialRoute: "/splash",
        getPages: appRoutes(),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      );
    });
  }
}
