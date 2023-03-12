import 'package:get/get.dart';

class NotifController extends GetxController {
  RxInt notifCount = 0.obs;

  void increment() {
    notifCount = notifCount + 1;
  }

  void decrement() {
    notifCount = notifCount - 1;
  }
}
