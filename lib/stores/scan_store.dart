// todo.dart
import 'dart:convert';

import 'package:event/model/scan_result.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'scan_store.g.dart';

class ScanStore = _ScanStore with _$ScanStore;

abstract class _ScanStore with Store {
  /* rest of the class*/
  @observable ScanResult result;
  @observable String code="";
  @observable dynamic json_response;
  @action
  Future<dynamic> scanCode() async {

    var response;
    response = '';
    response = await API.scanCode(code);
    //print(response);
    result=ScanResult.fromJson(json.decode(response));
    json_response=json.decode(response);
    print(result.message);
    return result;
  }
}