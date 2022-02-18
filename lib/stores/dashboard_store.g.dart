// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DashboardStore on _DashboardStore, Store {
  final _$selected_dateAtom = Atom(name: '_DashboardStore.selected_date');

  @override
  dynamic get selected_date {
    _$selected_dateAtom.reportRead();
    return super.selected_date;
  }

  @override
  set selected_date(dynamic value) {
    _$selected_dateAtom.reportWrite(value, super.selected_date, () {
      super.selected_date = value;
    });
  }

  final _$clientAtom = Atom(name: '_DashboardStore.client');

  @override
  Client? get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(Client? value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

  final _$isClientReadyAtom = Atom(name: '_DashboardStore.isClientReady');

  @override
  bool get isClientReady {
    _$isClientReadyAtom.reportRead();
    return super.isClientReady;
  }

  @override
  set isClientReady(bool value) {
    _$isClientReadyAtom.reportWrite(value, super.isClientReady, () {
      super.isClientReady = value;
    });
  }

  final _$userAtom = Atom(name: '_DashboardStore.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$isUserReadyAtom = Atom(name: '_DashboardStore.isUserReady');

  @override
  bool get isUserReady {
    _$isUserReadyAtom.reportRead();
    return super.isUserReady;
  }

  @override
  set isUserReady(bool value) {
    _$isUserReadyAtom.reportWrite(value, super.isUserReady, () {
      super.isUserReady = value;
    });
  }

  final _$dashboardSummaryAtom = Atom(name: '_DashboardStore.dashboardSummary');

  @override
  DashboardSummary? get dashboardSummary {
    _$dashboardSummaryAtom.reportRead();
    return super.dashboardSummary;
  }

  @override
  set dashboardSummary(DashboardSummary? value) {
    _$dashboardSummaryAtom.reportWrite(value, super.dashboardSummary, () {
      super.dashboardSummary = value;
    });
  }

  final _$isDashboardSummaryReadyAtom =
      Atom(name: '_DashboardStore.isDashboardSummaryReady');

  @override
  bool get isDashboardSummaryReady {
    _$isDashboardSummaryReadyAtom.reportRead();
    return super.isDashboardSummaryReady;
  }

  @override
  set isDashboardSummaryReady(bool value) {
    _$isDashboardSummaryReadyAtom
        .reportWrite(value, super.isDashboardSummaryReady, () {
      super.isDashboardSummaryReady = value;
    });
  }

  final _$visitor1Atom = Atom(name: '_DashboardStore.visitor1');

  @override
  int? get visitor1 {
    _$visitor1Atom.reportRead();
    return super.visitor1;
  }

  @override
  set visitor1(int? value) {
    _$visitor1Atom.reportWrite(value, super.visitor1, () {
      super.visitor1 = value;
    });
  }

  final _$visitor2Atom = Atom(name: '_DashboardStore.visitor2');

  @override
  int? get visitor2 {
    _$visitor2Atom.reportRead();
    return super.visitor2;
  }

  @override
  set visitor2(int? value) {
    _$visitor2Atom.reportWrite(value, super.visitor2, () {
      super.visitor2 = value;
    });
  }

  final _$dashboardActivityAtom =
      Atom(name: '_DashboardStore.dashboardActivity');

  @override
  DashboardActivity? get dashboardActivity {
    _$dashboardActivityAtom.reportRead();
    return super.dashboardActivity;
  }

  @override
  set dashboardActivity(DashboardActivity? value) {
    _$dashboardActivityAtom.reportWrite(value, super.dashboardActivity, () {
      super.dashboardActivity = value;
    });
  }

  final _$isDashboardActivityReadyAtom =
      Atom(name: '_DashboardStore.isDashboardActivityReady');

  @override
  bool get isDashboardActivityReady {
    _$isDashboardActivityReadyAtom.reportRead();
    return super.isDashboardActivityReady;
  }

  @override
  set isDashboardActivityReady(bool value) {
    _$isDashboardActivityReadyAtom
        .reportWrite(value, super.isDashboardActivityReady, () {
      super.isDashboardActivityReady = value;
    });
  }

  final _$dashboardPrizeAtom = Atom(name: '_DashboardStore.dashboardPrize');

  @override
  DashboardPrize? get dashboardPrize {
    _$dashboardPrizeAtom.reportRead();
    return super.dashboardPrize;
  }

  @override
  set dashboardPrize(DashboardPrize? value) {
    _$dashboardPrizeAtom.reportWrite(value, super.dashboardPrize, () {
      super.dashboardPrize = value;
    });
  }

  final _$isDashboardPrizeReadyAtom =
      Atom(name: '_DashboardStore.isDashboardPrizeReady');

  @override
  bool get isDashboardPrizeReady {
    _$isDashboardPrizeReadyAtom.reportRead();
    return super.isDashboardPrizeReady;
  }

  @override
  set isDashboardPrizeReady(bool value) {
    _$isDashboardPrizeReadyAtom.reportWrite(value, super.isDashboardPrizeReady,
        () {
      super.isDashboardPrizeReady = value;
    });
  }

  @override
  String toString() {
    return '''
selected_date: ${selected_date},
client: ${client},
isClientReady: ${isClientReady},
user: ${user},
isUserReady: ${isUserReady},
dashboardSummary: ${dashboardSummary},
isDashboardSummaryReady: ${isDashboardSummaryReady},
visitor1: ${visitor1},
visitor2: ${visitor2},
dashboardActivity: ${dashboardActivity},
isDashboardActivityReady: ${isDashboardActivityReady},
dashboardPrize: ${dashboardPrize},
isDashboardPrizeReady: ${isDashboardPrizeReady}
    ''';
  }
}
