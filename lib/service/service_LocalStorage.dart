import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  void save(String storageName, String dataSave) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(storageName, (dataSave));
  }

  Future<String?> getStorage(String storageName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(storageName);
  }

  void deleteStorage(String storageName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(storageName);
  }
}
