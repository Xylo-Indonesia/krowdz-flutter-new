// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_detail.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VisitorDetailStore on _VisitorDetailStore, Store {
  final _$jsonResponseAtom = Atom(name: '_VisitorDetailStore.jsonResponse');

  @override
  dynamic get jsonResponse {
    _$jsonResponseAtom.reportRead();
    return super.jsonResponse;
  }

  @override
  set jsonResponse(dynamic value) {
    _$jsonResponseAtom.reportWrite(value, super.jsonResponse, () {
      super.jsonResponse = value;
    });
  }

  final _$isDataReadyAtom = Atom(name: '_VisitorDetailStore.isDataReady');

  @override
  bool get isDataReady {
    _$isDataReadyAtom.reportRead();
    return super.isDataReady;
  }

  @override
  set isDataReady(bool value) {
    _$isDataReadyAtom.reportWrite(value, super.isDataReady, () {
      super.isDataReady = value;
    });
  }

  final _$acAtom = Atom(name: '_VisitorDetailStore.ac');

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

  @override
  String toString() {
    return '''
jsonResponse: ${jsonResponse},
isDataReady: ${isDataReady},
ac: ${ac}
    ''';
  }
}
