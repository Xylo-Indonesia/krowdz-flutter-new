// todo.dart
import 'dart:convert';

import 'package:event/model/notification_create.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';

part 'notification_create_store.g.dart';

class NotificationCreateStore = _NotificationCreateStore
    with _$NotificationCreateStore;

abstract class _NotificationCreateStore with Store {
  @observable
  Users? users;

  @observable
  bool isUsersListReady = false;

  void getUsersList() async {
    isUsersListReady = false;

    var response = await API.GetUsersList();
    users = Users.fromJson(json.decode(response));

    if (users?.status == true) {
      isUsersListReady = true;
    }
  }
}
