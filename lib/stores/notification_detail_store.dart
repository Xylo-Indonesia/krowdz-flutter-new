// todo.dart
import 'dart:convert';

import 'package:event/model/notification_detail.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'notification_detail_store.g.dart';

class NotificationDetailStore = _NotificationDetailStore
    with _$NotificationDetailStore;

abstract class _NotificationDetailStore with Store {
  /* rest of the class*/
  @observable
  NotificationDetail? notification;

  @observable
  bool isNotificationDetailReady = false;

  void getNotificationDetail(int id) async {
    isNotificationDetailReady = false;

    var response = await API.GeneralNotificationDetail(id);
    notification = NotificationDetail.fromJson(json.decode(response));

    if (notification?.status == true) {
      isNotificationDetailReady = true;
    }
  }
}
