// todo.dart
import 'dart:convert';

import 'package:event/model/form_entity.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'new_visitor_store.g.dart';

class NewVisitor = _NewVisitor with _$NewVisitor;

abstract class _NewVisitor with Store {
  @observable Entity? entity;
  @observable String? formString;
  /* rest of the class*/
  void getRegisterEntity()async{
    var response= await API.getRegisterEntity();
    entity=Entity.fromJson(json.decode(response));
    var dyn_data=entity!.data;
    //print(dyn_data[0]['placeholder']);

    formString=json.encode({
      'autoValidated': false,
      'fields':entity!.data
    }
    );

  }

  @observable
  ObservableFuture<dynamic>? responseSubmit;

  @observable bool isSubmit=false ;

  @action
  Future<dynamic> submitNewUser(dynamic data) async{
    if(!isSubmit) {
      isSubmit=true;
      print("datafields:" + data["fields"].toString());
      var kv = '';
      // data["fields"].forEach((k,v){
      //     kv=kv+k.toString()+':'+v.toString()+',';
      //   }
      // );
      Map<String?, dynamic> newjson = new Map<String?, dynamic>();
      ;
      for (dynamic field in data["fields"]) {
        kv = kv + '"' + field["name"] + '"' + ':' + field["value"] + ',';
        newjson[field["name"]] = field["value"];
      }
      kv = '{' + kv + '}';
      print('kv: ' + kv);

      var body = json.encode(kv);
      print('body json:' + newjson.toString());

      // responseSubmit=ObservableFuture(API.doRegisterNewVisitor(newjson).then((response2){
      //   response=response2;
      //    return response2;
      // }));
      var response;
      response = '';
      response = await API.doRegisterNewVisitor(newjson);
      isSubmit=false;
      return response;
    }
  }
}