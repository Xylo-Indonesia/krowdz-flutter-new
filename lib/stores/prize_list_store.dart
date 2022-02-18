// todo.dart
import 'dart:convert';

import 'package:event/model/activity.dart';
import 'package:event/model/dashboard_prize.dart';
import 'package:event/model/rewards.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'prize_list_store.g.dart';

class PrizeListStore = _PrizeListStore with _$PrizeListStore;

abstract class _PrizeListStore with Store {
  /* rest of the class*/
  @observable Rewards? rewards=null;
  @observable Activity? ac=null;
  @observable String? keyword='',activity='';

  void getDashboardPrize() async{
    print("get dashboard prize");
    var response= await API.RewardList(keyword: keyword!,activity: activity!);
    print(response);
    rewards=Rewards.fromJson(json.decode(response));
  }

  void getActivity() async{
    print("get dashboard activity");
    var response= await API.ActivityList();
    ac=Activity.fromJson(json.decode(response));
    print(response);

  }
}