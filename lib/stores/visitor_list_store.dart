// visitor_list_store.dart
import 'dart:convert';

import 'package:event/model/keymap.dart';
import 'package:event/model/visitor.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'visitor_list_store.g.dart';

class VisitorListStore = _VisitorListStore with _$VisitorListStore;

abstract class _VisitorListStore with Store {
  /* rest of the class*/
  @observable
  KeyMap? selectedKey, selectedKey2;
  @observable
  String? keyword = '';

  @observable
  Visitor? visitor;
  @observable
  bool isVisitorReady = false;

  @observable
  List<KeyMap>? items;
  @observable
  List<KeyMap>? items2;

  @observable
  Map<String, dynamic>? dyn_visitor;

  @observable
  String page = "1";
  @observable
  String order_by = "created_at";

  //pagination
  @observable
  bool hasNext = true;
  @observable
  bool hasPrev = true;
  @observable
  bool hasPagination = true;

  void getVisitorList(
      {String keyword = '',
      String keyword_by = '',
      String page = '',
      String order_direction = ''}) async {
    isVisitorReady = false;
    var response = await API.VisitorList(
        keyword: keyword,
        keyword_by: keyword_by,
        page: page,
        order_direction: order_direction);
    print(response);
    visitor = Visitor.fromJson(json.decode(response));
    dyn_visitor = await jsonDecode(response);

    if (null == selectedKey) {
      items = [];
      dyn_visitor!["meta"]["category"].forEach((k, v) {
        items!.add(KeyMap(k.toString(), v.toString()));
        if (null != keyword_by && keyword_by.length > 0) {
          if (keyword_by == k.toString()) selectedKey = items!.last;
        } else {
          selectedKey = items!.first;
        }
      });
      //sorting asc desc
      items2 = [];
      items2!.add(KeyMap("asc", "A to Z"));
      items2!.add(KeyMap("desc", "Z to A"));
      // items.add(KeyMap("code", visitor.meta.keymapper.code));
      // items.add(KeyMap("email", visitor.meta.keymapper.email));
      // items.add(KeyMap("city", visitor.meta.keymapper.city));
      // items.add(KeyMap("gender", visitor.meta.keymapper.gender));
      // items.add(KeyMap("phone_number", visitor.meta.keymapper.phoneNumber));
      print("Items:" + items!.length.toString());
      //selectedKey = items[0];
      selectedKey2 = items2![0];
    }
    //print("Data Visitor:"+dyn_visitor["data"][0]["name"].toString());

    //getpagination data
    hasNext = (null != visitor!.links!.next) ? true : false;
    hasPrev = (null != visitor!.links!.prev) ? true : false;
    hasPagination = (hasNext || hasPrev) ? true : false;

    isVisitorReady = true;
  }

  void getVisitorDataByField(Visitor v, String field) async {}

  void doNextPage() {
    if (hasNext) {
      getVisitorList(
          keyword: keyword!,
          keyword_by: selectedKey!.key,
          page: (visitor!.meta!.currentPage! + 1).toString());
    } else {
      print('no next page');
    }
  }

  void doPrevPage() {
    if (hasPrev) {
      getVisitorList(
          keyword: keyword!,
          keyword_by: selectedKey!.key,
          page: (visitor!.meta!.currentPage! - 1).toString());
    } else {
      print('no prev page');
    }
  }
}
