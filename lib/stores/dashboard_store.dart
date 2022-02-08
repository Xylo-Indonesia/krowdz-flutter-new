// dashboard.dart
import 'dart:convert';

import 'package:event/model/client.dart';
import 'package:event/model/dashboard_activity.dart';
import 'package:event/model/dashboard_prize.dart';
import 'package:event/model/dashboard_summary.dart';
import 'package:event/model/user.dart';
import 'package:event/services/http_request.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_store.g.dart';

class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  /* rest of the class*/
  @observable var selected_date;

  @observable Client client;
  @observable bool isClientReady=false;
  @observable User user;
  @observable bool isUserReady=false;

  @observable
  DashboardSummary dashboardSummary=null;
  @observable bool isDashboardSummaryReady=false;
  @observable int visitor1=0;
  @observable int visitor2=0;

  @observable DashboardActivity dashboardActivity=null;
  @observable bool isDashboardActivityReady=false;
  @observable DashboardPrize dashboardPrize=null;
  @observable bool isDashboardPrizeReady=false;

  void getDate(){
    final now = new DateTime.now();
    String formatter = DateFormat('d MMM yyyy').format(now);
    selected_date=formatter;
  }
  void setDate(var now){
    String formatter = DateFormat('d MMM yyyy').format(now);
    selected_date=formatter;
  }

  void getDashboardSummary() async{
    print("get dashboard summary");
    var response= await API.DashboardSummary();
    print(response);
    dashboardSummary=DashboardSummary.fromJson(json.decode(response));
    if(true==dashboardSummary.status) {
      visitor1 = dashboardSummary.data.online.total;
      visitor2 = dashboardSummary.data.offline.total;
      isDashboardSummaryReady=true;
    }
  }

  void getDashboardActivity() async{
    print("get dashboard activity");
    var response= await API.DashboardActivity();
    dashboardActivity=DashboardActivity.fromJson(json.decode(response));
    print(response);
    if(true==dashboardActivity.status) {
      isDashboardActivityReady=true;
    }
  }

  void getDashboardPrize() async{
    print("get dashboard prize");
    var response= await API.DashboardPrize();
    print(response);
    dashboardPrize=DashboardPrize.fromJson(json.decode(response));
    if(true==dashboardPrize.status) {
      isDashboardPrizeReady=true;
    }

  }

  void getClient() async{
    print(Hive.isBoxOpen('client').toString());
    Box<Client> box=  Hive.box<Client>('client');

    print(box.isEmpty.toString()+box.isOpen.toString());
    client=box.get(0);
    if(client!=null)isClientReady=true;
  }

  void getUser() async{
    Box<User> box= Hive.box<User>('user');
    user=box.get(0);
    if(user!=null)isUserReady=true;
  }
}