// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationDetailStore on _NotificationDetailStore, Store {
  final _$notificationAtom =
      Atom(name: '_NotificationDetailStore.notification');

  @override
  NotificationDetail? get notification {
    _$notificationAtom.reportRead();
    return super.notification;
  }

  @override
  set notification(NotificationDetail? value) {
    _$notificationAtom.reportWrite(value, super.notification, () {
      super.notification = value;
    });
  }

  final _$isNotificationDetailReadyAtom =
      Atom(name: '_NotificationDetailStore.isNotificationDetailReady');

  @override
  bool get isNotificationDetailReady {
    _$isNotificationDetailReadyAtom.reportRead();
    return super.isNotificationDetailReady;
  }

  @override
  set isNotificationDetailReady(bool value) {
    _$isNotificationDetailReadyAtom
        .reportWrite(value, super.isNotificationDetailReady, () {
      super.isNotificationDetailReady = value;
    });
  }

  @override
  String toString() {
    return '''
notification: ${notification},
isNotificationDetailReady: ${isNotificationDetailReady}
    ''';
  }
}
