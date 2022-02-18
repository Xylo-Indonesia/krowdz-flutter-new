// todo.dart
import 'dart:convert';

import 'package:event/model/notification.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  /* rest of the class*/
  @observable
  Notification? general = null;
  @observable
  Notification? announcements = null;
  @observable
  String keyword = '', activity = '';

  void getGeneralNotifications() async {
    var response = await API.GeneralNotificationList();
    general = Notification.fromJson(json.decode(response));

    print(response);
  }

  void getAnnouncements() async {
    var response = await API.AnnouncementList();
    announcements = Notification.fromJson(json.decode(response));

    print(response);
  }
}
