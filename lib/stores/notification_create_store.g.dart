// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationCreateStore on _NotificationCreateStore, Store {
  final _$usersAtom = Atom(name: '_NotificationCreateStore.users');

  @override
  Users? get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(Users? value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$isUsersListReadyAtom =
      Atom(name: '_NotificationCreateStore.isUsersListReady');

  @override
  bool get isUsersListReady {
    _$isUsersListReadyAtom.reportRead();
    return super.isUsersListReady;
  }

  @override
  set isUsersListReady(bool value) {
    _$isUsersListReadyAtom.reportWrite(value, super.isUsersListReady, () {
      super.isUsersListReady = value;
    });
  }

  @override
  String toString() {
    return '''
users: ${users},
isUsersListReady: ${isUsersListReady}
    ''';
  }
}
