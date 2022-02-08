// todo.dart
import 'dart:convert';

import 'package:event/model/activity.dart';
import 'package:event/model/form_entity.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'new_activity_store.g.dart';

class NewActivityStore = _NewActivityStore with _$NewActivityStore;

abstract class _NewActivityStore with Store {
  dynamic activity;
  dynamic visitor;
  bool isEdit=false;
  dynamic activityHistory;

  @observable Entity entity;
  @observable String formString;
  /* rest of the class*/
  void getRegisterEntity()async{
    var response= await API.getRegisterEntityById(activity.id.toString());
    //print(response);
    entity=Entity.fromJson(json.decode(response));
    var dyn_data=entity.data;
    print(dyn_data[0]['label']);

    if(isEdit){
      print("Activity History:"+activityHistory.toString());
      entity.data.forEach((v){
        //print(k.toString()+v.toString()) ;

        if(null!=activityHistory[""+v["name"]])
        v["value"]=activityHistory[""+v["name"]];
        print(v.toString());
      });
    }

    formString=json.encode({
      'autoValidated': false,
      'fields':entity.data
    }
    );

  }

  @observable
  ObservableFuture<dynamic> responseSubmit;

  @observable bool isSubmit=false ;

  @action
  Future<dynamic> submitNewActivity(dynamic data) async{
    if(!isSubmit) {
      isSubmit=true;
      print("datafields:" + data["fields"].toString());
      var kv = '';
      // data["fields"].forEach((k,v){
      //     kv=kv+k.toString()+':'+v.toString()+',';
      //   }
      // );
      Map<String, dynamic> newjson = new Map<String, dynamic>();
      ;

      for (dynamic field in data["fields"]) {
        print("Debug:"+field["name"]+field["value"]);
          kv = kv + '"' + field["name"] + '"' + ':' + field["value"] + ',';
        newjson[field["name"]] = field["value"];
      }
      kv = '{' + kv + '}';
      print('kv: ' + kv);

      var body = json.encode(kv);
      print('body json:' + newjson.toString());

      // responseSubmit=ObservableFuture(API.doRegisterNewActivity(newjson).then((response2){
      //   response=response2;
      //    return response2;
      // }));
      var response;
      response = '';
      if(!isEdit) response = await API.doRegisterNewActivity(newjson,activity.id.toString(),visitor["id"].toString());
      else response = await API.doEditActivity(newjson,activity.id.toString(),visitor["id"].toString());
      isSubmit=false;

      return response;
    }
  }
}