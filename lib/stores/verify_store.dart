// todo.dart
import 'dart:convert';

import 'package:event/model/client.dart';
import 'package:event/model/response.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/http_request.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

part 'verify_store.g.dart';

class VerifyStore = _VerifyStore with _$VerifyStore;

abstract class _VerifyStore with Store {
  /* rest of the class*/
  final API httpClient = API();
  final FormVerifyErrorState error = FormVerifyErrorState();

  @observable
  ObservableFuture<Response> response;

  @observable
  bool status = false;

  //parameter
  @observable
  String code = '';

  @computed
  bool get canSubmit => !error.hasErrors;

  @action
  Future doVerify(BuildContext context) => response = ObservableFuture(
          httpClient.doVerify(this.code).then((response) async {
        print(this.code + " " + response);
        Response myResponse = Response.fromJson(json.decode(response));

        if ("true" == myResponse.status) {
          Client client = Client.fromJson(myResponse.data);
          var box = Hive.box<Client>('client');

          box.clear().then((value) => {box.put(0, client)});
          //await box.put(0,client);
          print("Box not empty:" + box.isNotEmpty.toString());
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString(pref_url_logo, client.logo);
            prefs.setString(pref_api_url, client.apiUrl);
          });

          Navigator.pushReplacementNamed(context, loginPageRoute);
        } else {
          String msg = myResponse.message;
          error.code = msg.toString().replaceAll("[", "").replaceAll("]", "");
        }
        return myResponse;
      }).catchError((e) {
        print(e);
      }));
  @action
  // ignore: avoid_void_async
  Future validateCode(String value) async {
    if (isNull(value) || value.isEmpty) {
      error.code = 'Cannot be blank';
      return;
    }
    error.code = null;
  }

  List<ReactionDisposer> _disposers;
  void setupValidations() {
    _disposers = [
      reaction((_) => code, validateCode),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll(BuildContext context) {
    validateCode(code);
    if (canSubmit) {
      error.code = "Checking Code";
      doVerify(context);
    }
  }
}

class FormVerifyErrorState = _FormVerifyErrorState with _$FormVerifyErrorState;

abstract class _FormVerifyErrorState with Store {
  @observable
  String code;

  @computed
  bool get hasErrors => code != null;
}
