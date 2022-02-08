// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScanStore on _ScanStore, Store {
  final _$resultAtom = Atom(name: '_ScanStore.result');

  @override
  ScanResult get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(ScanResult value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$codeAtom = Atom(name: '_ScanStore.code');

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$json_responseAtom = Atom(name: '_ScanStore.json_response');

  @override
  dynamic get json_response {
    _$json_responseAtom.reportRead();
    return super.json_response;
  }

  @override
  set json_response(dynamic value) {
    _$json_responseAtom.reportWrite(value, super.json_response, () {
      super.json_response = value;
    });
  }

  final _$scanCodeAsyncAction = AsyncAction('_ScanStore.scanCode');

  @override
  Future<dynamic> scanCode() {
    return _$scanCodeAsyncAction.run(() => super.scanCode());
  }

  @override
  String toString() {
    return '''
result: ${result},
code: ${code},
json_response: ${json_response}
    ''';
  }
}
