import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  bool isloading = false;
  String nikUser = "";
  String fcmToken = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Container _buildBody() {
    return Container(
      height: 90.h,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3c6e71), width: 4.0),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://kerma.widyatama.ac.id/wp-content/uploads/2021/05/blank-profile-picture-973460_1280.png'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Text('Mr. Fredi'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 14.sp),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff3c6e71),
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {},
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text("Logout"),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
