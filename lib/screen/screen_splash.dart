import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:MyMovie/color.dart';
import 'package:sizer/sizer.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  void checkApps() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Get.offAndToNamed("/main");
  }

  @override
  void initState() {
    checkApps();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.9],
                  colors: [
                    AppColors.primaryColor,
                    Colors.orange.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                const SpinKitChasingDots(
                  color: Color.fromARGB(255, 227, 39, 39),
                  size: 50.0,
                ),
              ],
            ),
            Center(
                child: Text(
              "My Movie's",
              style: TextStyle(fontSize: 40.sp, color: Colors.brown),
            ))
          ],
        ),
      ),
    );
  }
}
