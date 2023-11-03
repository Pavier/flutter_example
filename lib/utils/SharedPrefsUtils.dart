import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils{

  static setPrefix(String prefix, {Set<String>? allowList}) {
    SharedPreferences.setPrefix(prefix, allowList: allowList);
  }

  static setInt(String key, int value)async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static int? getInt(String key){
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getInt(key);
    });
    return null;
  }

  static setDouble(String key, double value)async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static double? getDouble(String key){
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getDouble(key);
    });
    return null;
  }

  static setBool(String key, bool value) async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static bool? getBool(String key){
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getBool(key);
    });
    return null;
  }

  static setString(String key, String value) async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static String? getString(String key){
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getString(key);
    });
    return null;
  }

  static setStringList(String key, List<String> value) async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  static List<String>? getStringList(String key){
    SharedPreferences.getInstance().then((prefs) {
      return prefs.getStringList(key);
    });
    return null;
  }

  static remove(String key) async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

}