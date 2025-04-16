import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String get(String key) => _sharedPrefs.getString(key) ?? '';

  List<String> getList(String key) => _sharedPrefs.getStringList(key) ?? [];

  void set(String key, String value) {
    _sharedPrefs.setString(key, value);
  }

  void setList(String key, List<String> value) {
    _sharedPrefs.setStringList(key, value);
  }

  bool has(String key) => _sharedPrefs.containsKey(key);

  void remove(String key) => _sharedPrefs.remove(key);

  void clear() => _sharedPrefs.clear();
}

//final sharedPrefs = SharedPrefs();
