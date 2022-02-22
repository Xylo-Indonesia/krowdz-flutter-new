// todo.dart
import 'dart:convert';

import 'package:event/model/notification.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'notification_list_store.g.dart';

class NotificationListStore = _NotificationListStore
    with _$NotificationListStore;

abstract class _NotificationListStore with Store {
  /* rest of the class*/
  @observable
  Notification? general;
  @observable
  Notification? announcements;

  @observable
  String generalPage = "1";
  @observable
  String announcementsPage = "1";

  //pagination
  @observable
  bool generalHasNext = true;
  @observable
  bool generalHasPrev = true;
  @observable
  bool generalHasPagination = true;

  //pagination
  @observable
  bool announcementsHasNext = true;
  @observable
  bool announcementsHasPrev = true;
  @observable
  bool announcementsHasPagination = true;

  void getGeneralNotifications({
    String page = '1',
  }) async {
    var response = await API.GeneralNotificationList(
      page: page,
    );
    general = Notification.fromJson(json.decode(response));
    //getpagination data
    generalHasNext = (null != general!.links!.next) ? true : false;
    generalHasPrev = (null != general!.links!.prev) ? true : false;
    generalHasPagination = (generalHasNext || generalHasPrev) ? true : false;

    // print('general notifications');
    // print(general);
  }

  void getAnnouncements({
    String page = '1',
  }) async {
    var response = await API.AnnouncementList(
      page: page,
    );
    announcements = Notification.fromJson(json.decode(response));

    //getpagination data
    announcementsHasNext = (null != announcements!.links!.next) ? true : false;
    announcementsHasPrev = (null != announcements!.links!.prev) ? true : false;
    announcementsHasPagination =
        (announcementsHasNext || announcementsHasPrev) ? true : false;

    // print('announcements');
    // print(response);
  }

  void doNextPage(String type) {
    if (type == 'general' && generalHasNext) {
      getGeneralNotifications(page: general!.links!.next!);
    }

    if (type == 'announcement' && announcementsHasNext) {
      getAnnouncements(page: announcements!.links!.next!);
    }
  }

  void doPrevPage(String type) {
    if (type == 'general' && generalHasPrev) {
      getGeneralNotifications(page: general!.links!.next!);
    }

    if (type == 'announcement' && announcementsHasPrev) {
      getAnnouncements(page: announcements!.links!.next!);
    }
  }
}
