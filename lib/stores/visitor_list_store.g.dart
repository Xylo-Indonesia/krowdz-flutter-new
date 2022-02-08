// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VisitorListStore on _VisitorListStore, Store {
  final _$selectedKeyAtom = Atom(name: '_VisitorListStore.selectedKey');

  @override
  KeyMap get selectedKey {
    _$selectedKeyAtom.reportRead();
    return super.selectedKey;
  }

  @override
  set selectedKey(KeyMap value) {
    _$selectedKeyAtom.reportWrite(value, super.selectedKey, () {
      super.selectedKey = value;
    });
  }

  final _$selectedKey2Atom = Atom(name: '_VisitorListStore.selectedKey2');

  @override
  KeyMap get selectedKey2 {
    _$selectedKey2Atom.reportRead();
    return super.selectedKey2;
  }

  @override
  set selectedKey2(KeyMap value) {
    _$selectedKey2Atom.reportWrite(value, super.selectedKey2, () {
      super.selectedKey2 = value;
    });
  }

  final _$keywordAtom = Atom(name: '_VisitorListStore.keyword');

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

  final _$visitorAtom = Atom(name: '_VisitorListStore.visitor');

  @override
  Visitor get visitor {
    _$visitorAtom.reportRead();
    return super.visitor;
  }

  @override
  set visitor(Visitor value) {
    _$visitorAtom.reportWrite(value, super.visitor, () {
      super.visitor = value;
    });
  }

  final _$isVisitorReadyAtom = Atom(name: '_VisitorListStore.isVisitorReady');

  @override
  bool get isVisitorReady {
    _$isVisitorReadyAtom.reportRead();
    return super.isVisitorReady;
  }

  @override
  set isVisitorReady(bool value) {
    _$isVisitorReadyAtom.reportWrite(value, super.isVisitorReady, () {
      super.isVisitorReady = value;
    });
  }

  final _$itemsAtom = Atom(name: '_VisitorListStore.items');

  @override
  List<KeyMap> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<KeyMap> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$items2Atom = Atom(name: '_VisitorListStore.items2');

  @override
  List<KeyMap> get items2 {
    _$items2Atom.reportRead();
    return super.items2;
  }

  @override
  set items2(List<KeyMap> value) {
    _$items2Atom.reportWrite(value, super.items2, () {
      super.items2 = value;
    });
  }

  final _$dyn_visitorAtom = Atom(name: '_VisitorListStore.dyn_visitor');

  @override
  Map<String, dynamic> get dyn_visitor {
    _$dyn_visitorAtom.reportRead();
    return super.dyn_visitor;
  }

  @override
  set dyn_visitor(Map<String, dynamic> value) {
    _$dyn_visitorAtom.reportWrite(value, super.dyn_visitor, () {
      super.dyn_visitor = value;
    });
  }

  final _$pageAtom = Atom(name: '_VisitorListStore.page');

  @override
  String get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(String value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$order_byAtom = Atom(name: '_VisitorListStore.order_by');

  @override
  String get order_by {
    _$order_byAtom.reportRead();
    return super.order_by;
  }

  @override
  set order_by(String value) {
    _$order_byAtom.reportWrite(value, super.order_by, () {
      super.order_by = value;
    });
  }

  final _$hasNextAtom = Atom(name: '_VisitorListStore.hasNext');

  @override
  bool get hasNext {
    _$hasNextAtom.reportRead();
    return super.hasNext;
  }

  @override
  set hasNext(bool value) {
    _$hasNextAtom.reportWrite(value, super.hasNext, () {
      super.hasNext = value;
    });
  }

  final _$hasPrevAtom = Atom(name: '_VisitorListStore.hasPrev');

  @override
  bool get hasPrev {
    _$hasPrevAtom.reportRead();
    return super.hasPrev;
  }

  @override
  set hasPrev(bool value) {
    _$hasPrevAtom.reportWrite(value, super.hasPrev, () {
      super.hasPrev = value;
    });
  }

  final _$hasPaginationAtom = Atom(name: '_VisitorListStore.hasPagination');

  @override
  bool get hasPagination {
    _$hasPaginationAtom.reportRead();
    return super.hasPagination;
  }

  @override
  set hasPagination(bool value) {
    _$hasPaginationAtom.reportWrite(value, super.hasPagination, () {
      super.hasPagination = value;
    });
  }

  @override
  String toString() {
    return '''
selectedKey: ${selectedKey},
selectedKey2: ${selectedKey2},
keyword: ${keyword},
visitor: ${visitor},
isVisitorReady: ${isVisitorReady},
items: ${items},
items2: ${items2},
dyn_visitor: ${dyn_visitor},
page: ${page},
order_by: ${order_by},
hasNext: ${hasNext},
hasPrev: ${hasPrev},
hasPagination: ${hasPagination}
    ''';
  }
}
