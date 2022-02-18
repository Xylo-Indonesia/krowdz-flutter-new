// todo.dart
import 'dart:convert';

import 'package:event/model/activity.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'visitor_detail.g.dart';

class VisitorDetailStore = _VisitorDetailStore with _$VisitorDetailStore;

abstract class _VisitorDetailStore with Store {
  @observable var jsonResponse;
  @observable bool isDataReady=false;
  @observable Activity? ac;


  /* rest of the class*/
  void getVisitor(String id) async{
    var response= await API.VisitorDetail(id);
    jsonResponse=json.decode(response);
    jsonResponse["data"].forEach((k,v){
      print(k.toString()+":"+v.toString());
    });
    isDataReady=true;
  }

  void getActivity() async{
    print("get dashboard activity");
    var response= await API.ActivityList();
    ac=Activity.fromJson(json.decode(response));

    print(response);

  }
}