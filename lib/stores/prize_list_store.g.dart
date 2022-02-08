// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prize_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrizeListStore on _PrizeListStore, Store {
  final _$rewardsAtom = Atom(name: '_PrizeListStore.rewards');

  @override
  Rewards get rewards {
    _$rewardsAtom.reportRead();
    return super.rewards;
  }

  @override
  set rewards(Rewards value) {
    _$rewardsAtom.reportWrite(value, super.rewards, () {
      super.rewards = value;
    });
  }

  final _$acAtom = Atom(name: '_PrizeListStore.ac');

  @override
  Activity get ac {
    _$acAtom.reportRead();
    return super.ac;
  }

  @override
  set ac(Activity value) {
    _$acAtom.reportWrite(value, super.ac, () {
      super.ac = value;
    });
  }

  final _$keywordAtom = Atom(name: '_PrizeListStore.keyword');

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

  final _$activityAtom = Atom(name: '_PrizeListStore.activity');

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
rewards: ${rewards},
ac: ${ac},
keyword: ${keyword},
activity: ${activity}
    ''';
  }
}
