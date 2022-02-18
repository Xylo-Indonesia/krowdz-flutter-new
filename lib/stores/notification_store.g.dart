// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationStore on _NotificationStore, Store {
  final _$generalAtom = Atom(name: '_NotificationStore.general');

  @override
  Notification? get general {
    _$generalAtom.reportRead();
    return super.general;
  }

  @override
  set general(Notification? value) {
    _$generalAtom.reportWrite(value, super.general, () {
      super.general = value;
    });
  }

  final _$announcementsAtom = Atom(name: '_NotificationStore.announcements');

  @override
  Notification? get announcements {
    _$announcementsAtom.reportRead();
    return super.announcements;
  }

  @override
  set announcements(Notification? value) {
    _$announcementsAtom.reportWrite(value, super.announcements, () {
      super.announcements = value;
    });
  }

  final _$keywordAtom = Atom(name: '_NotificationStore.keyword');

  @override
  String get keyword {
    _$keywordAtom.reportRead();
    return super.keyword;
  }

  @override
  set keyword(String value) {
    _$keywordAtom.reportWrite(value, super.keyword, () {
      super.keyword = value;
    });
  }

  final _$activityAtom = Atom(name: '_NotificationStore.activity');

  @override
  String get activity {
    _$activityAtom.reportRead();
    return super.activity;
  }

  @override
  set activity(String value) {
    _$activityAtom.reportWrite(value, super.activity, () {
      super.activity = value;
    });
  }

  @override
  String toString() {
    return '''
general: ${general},
announcements: ${announcements},
keyword: ${keyword},
activity: ${activity}
    ''';
  }
}
