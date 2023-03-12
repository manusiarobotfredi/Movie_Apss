import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final Widget body;
  final String title;
  final bool subMenu;
  final bool backScreen;
  final bool floatingbutton;
  final Widget? bottomNav;

  const MainScreen(
      {Key? key,
      required this.body,
      this.subMenu = false,
      required this.title,
      this.backScreen = true,
      this.floatingbutton = false,
      this.bottomNav,
    })
      : super(key: key);

  @override
    State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Color colors = Colors.white;
    return WillPopScope(
      onWillPop: () async {
        return widget.backScreen;
      },
      child: MaterialApp(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            extendBody: true,
            backgroundColor: colors,
            appBar: AppBar(
              backgroundColor: const Color(0xff3c6e71),
              elevation: 0,
              centerTitle: true,
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            body: widget.body,
            bottomNavigationBar: widget.bottomNav,
          ),
        );
      }),
    );
  }
}
