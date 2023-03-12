import 'dart:io';

import 'package:MyMovie/screen/screen_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MyMovie/color.dart';
import 'package:MyMovie/screen/screen_homepage.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with WidgetsBindingObserver {
  var index = 0;
  final items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Beranda",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: "Profile",
    ),
    // const Icon(Icons.document_scanner, size: 30),
    // const Icon(Icons.account_circle_outlined, size: 30),
  ];

  var screens = [const ScreenHomepage(), const ScreenProfile()];

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
    } else {
      if (!kDebugMode) {
        exit(0);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Color colors = Colors.white;
    return Scaffold(
      extendBody: true,
      backgroundColor: colors,
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        selectedItemColor: AppColors.primaryColor,
        // color: const Color.fromRGBO(217, 217, 217, 100),
        backgroundColor: colors,
        // buttonBackgroundColor: colors,
        // index: index,
        currentIndex: index,
        onTap: ((index) {
          setState(() {
            this.index = index;
          });
        }),
      ),
    );
  }
}
