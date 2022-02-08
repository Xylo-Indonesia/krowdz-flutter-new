// todo.dart
import 'package:event/services/consts.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  /* rest of the class*/

  @action
  Future<String> doLogout() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(pref_access_token, null);
    return 'true';
  }

}