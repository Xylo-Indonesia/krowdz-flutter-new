// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationListStore on _NotificationListStore, Store {
  final _$generalAtom = Atom(name: '_NotificationListStore.general');

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

  final _$announcementsAtom =
      Atom(name: '_NotificationListStore.announcements');

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

  final _$generalPageAtom = Atom(name: '_NotificationListStore.generalPage');

  @override
  String get generalPage {
    _$generalPageAtom.reportRead();
    return super.generalPage;
  }

  @override
  set generalPage(String value) {
    _$generalPageAtom.reportWrite(value, super.generalPage, () {
      super.generalPage = value;
    });
  }

  final _$announcementsPageAtom =
      Atom(name: '_NotificationListStore.announcementsPage');

  @override
  String get announcementsPage {
    _$announcementsPageAtom.reportRead();
    return super.announcementsPage;
  }

  @override
  set announcementsPage(String value) {
    _$announcementsPageAtom.reportWrite(value, super.announcementsPage, () {
      super.announcementsPage = value;
    });
  }

  final _$isGeneralPageReadyAtom =
      Atom(name: '_NotificationListStore.isGeneralPageReady');

  @override
  bool get isGeneralPageReady {
    _$isGeneralPageReadyAtom.reportRead();
    return super.isGeneralPageReady;
  }

  @override
  set isGeneralPageReady(bool value) {
    _$isGeneralPageReadyAtom.reportWrite(value, super.isGeneralPageReady, () {
      super.isGeneralPageReady = value;
    });
  }

  final _$isAnnouncementsPageReadyAtom =
      Atom(name: '_NotificationListStore.isAnnouncementsPageReady');

  @override
  bool get isAnnouncementsPageReady {
    _$isAnnouncementsPageReadyAtom.reportRead();
    return super.isAnnouncementsPageReady;
  }

  @override
  set isAnnouncementsPageReady(bool value) {
    _$isAnnouncementsPageReadyAtom
        .reportWrite(value, super.isAnnouncementsPageReady, () {
      super.isAnnouncementsPageReady = value;
    });
  }

  final _$generalHasNextAtom =
      Atom(name: '_NotificationListStore.generalHasNext');

  @override
  bool get generalHasNext {
    _$generalHasNextAtom.reportRead();
    return super.generalHasNext;
  }

  @override
  set generalHasNext(bool value) {
    _$generalHasNextAtom.reportWrite(value, super.generalHasNext, () {
      super.generalHasNext = value;
    });
  }

  final _$generalHasPrevAtom =
      Atom(name: '_NotificationListStore.generalHasPrev');

  @override
  bool get generalHasPrev {
    _$generalHasPrevAtom.reportRead();
    return super.generalHasPrev;
  }

  @override
  set generalHasPrev(bool value) {
    _$generalHasPrevAtom.reportWrite(value, super.generalHasPrev, () {
      super.generalHasPrev = value;
    });
  }

  final _$generalHasPaginationAtom =
      Atom(name: '_NotificationListStore.generalHasPagination');

  @override
  bool get generalHasPagination {
    _$generalHasPaginationAtom.reportRead();
    return super.generalHasPagination;
  }

  @override
  set generalHasPagination(bool value) {
    _$generalHasPaginationAtom.reportWrite(value, super.generalHasPagination,
        () {
      super.generalHasPagination = value;
    });
  }

  final _$announcementsHasNextAtom =
      Atom(name: '_NotificationListStore.announcementsHasNext');

  @override
  bool get announcementsHasNext {
    _$announcementsHasNextAtom.reportRead();
    return super.announcementsHasNext;
  }

  @override
  set announcementsHasNext(bool value) {
    _$announcementsHasNextAtom.reportWrite(value, super.announcementsHasNext,
        () {
      super.announcementsHasNext = value;
    });
  }

  final _$announcementsHasPrevAtom =
      Atom(name: '_NotificationListStore.announcementsHasPrev');

  @override
  bool get announcementsHasPrev {
    _$announcementsHasPrevAtom.reportRead();
    return super.announcementsHasPrev;
  }

  @override
  set announcementsHasPrev(bool value) {
    _$announcementsHasPrevAtom.reportWrite(value, super.announcementsHasPrev,
        () {
      super.announcementsHasPrev = value;
    });
  }

  final _$announcementsHasPaginationAtom =
      Atom(name: '_NotificationListStore.announcementsHasPagination');

  @override
  bool get announcementsHasPagination {
    _$announcementsHasPaginationAtom.reportRead();
    return super.announcementsHasPagination;
  }

  @override
  set announcementsHasPagination(bool value) {
    _$announcementsHasPaginationAtom
        .reportWrite(value, super.announcementsHasPagination, () {
      super.announcementsHasPagination = value;
    });
  }

  @override
  String toString() {
    return '''
general: ${general},
announcements: ${announcements},
generalPage: ${generalPage},
announcementsPage: ${announcementsPage},
isGeneralPageReady: ${isGeneralPageReady},
isAnnouncementsPageReady: ${isAnnouncementsPageReady},
generalHasNext: ${generalHasNext},
generalHasPrev: ${generalHasPrev},
generalHasPagination: ${generalHasPagination},
announcementsHasNext: ${announcementsHasNext},
announcementsHasPrev: ${announcementsHasPrev},
announcementsHasPagination: ${announcementsHasPagination}
    ''';
  }
}
