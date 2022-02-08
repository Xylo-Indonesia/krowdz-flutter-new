import 'dart:convert';
import 'dart:ui';

import 'package:event/model/client.dart';
import 'package:event/model/user.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/http_request.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

part 'form_login_store.g.dart';

class CustomColor extends Color {
  CustomColor(int value) : super(value);
}

class FormLoginStore = _FormLoginStore with _$FormLoginStore;

abstract class _FormLoginStore with Store {
  final FormLoginErrorState error = FormLoginErrorState();
  @observable String url_logo="https://dev.bounche.com/xylo-event-2020/login-placeholder.png";

  @observable
  Client client;

  @observable
  CustomColor color;

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  ObservableFuture<bool> usernameCheck = ObservableFuture.value(true);

  @computed
  bool get isUserCheckPending => usernameCheck.status == FutureStatus.pending;

  @computed
  bool get canLogin => !error.hasErrors;

  List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }
  void getClient () async {
    print('Getting Client');
    SharedPreferences.getInstance().then((prefs){
      url_logo=prefs.getString(pref_url_logo);
    });

  }



  @action
  void validatePassword (String value){
    error.password = isNull(value) || value.isEmpty ? 'Cannot be blank' : null;

  }

  @action
  Future validateEmail(String value) async {
    if(!isEmail(value) || value.isEmpty){
      error.email='Not a valid email';
      return;
    }
    error.email = null;
  }

  Future<bool> checkValidUsername(String value) async {
    var response=await API.loginPost(email, password);
    print('Response:'+response.toString());
    print('Saving box');

    User  user =User.fromJson(json.decode(response));
    if(false==user.status){
      error.email=user.message;
    }
    else{


        var box = Hive.box<User>('user');
        await box.clear();
        await box.put(0, user);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString(pref_access_token, user.data.accessToken);
        });

      print('Done');
    }
    return user.status;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  Future validateAll(context) async{
    validatePassword(password);
    validateEmail(email);
    if(error.email==null && error.password==null){
      try {
        usernameCheck = ObservableFuture(checkValidUsername(email));

        error.email = null;

        final isValid = await usernameCheck;
        if (!isValid) {
          //error.email = 'Wrong username / password';
          return;
        }else{
          print('HomePageRoute');
          Navigator.pushReplacementNamed(context, homePageRoute);

        }
      } on Object catch (_) {
        error.email = null;
      }
    }
  }
}

class FormLoginErrorState = _FormLoginErrorState with _$FormLoginErrorState;

abstract class _FormLoginErrorState with Store {
  @observable
  String username;

  @observable
  String email=' ';

  @observable
  String password=' ';

  @computed
  bool get hasErrors => username != null || email != null || password != null;
}
