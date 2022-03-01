// todo.dart
import 'dart:convert';

import 'package:event/model/notification_create.dart';
import 'package:event/services/http_request.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';

part 'notification_create_store.g.dart';

class NotificationCreateStore = _NotificationCreateStore
    with _$NotificationCreateStore;

abstract class _NotificationCreateStore with Store {
  @observable
  Users users = Users(data: []);

  @observable
  bool isUsersListReady = false;

  void getUsersList() async {
    isUsersListReady = false;

    var response = await API.GetUsersList();
    users = Users.fromJson(json.decode(response));

    if (users.status == true) {
      isUsersListReady = true;
    }
  }

  createGeneralNotification(
      String title, String message, bool isAllUsers, List recipients) async {
    var body = NotificationCreate(
            title: title,
            message: message,
            isAllUsers: isAllUsers,
            recipients: recipients)
        .toJson();

    Response response = await API.CreateGeneralNotification(body);
    var status = response.statusCode;

    return status;
  }
}
