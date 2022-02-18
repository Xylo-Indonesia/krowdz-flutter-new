// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VerifyStore on _VerifyStore, Store {
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit => (_$canSubmitComputed ??=
          Computed<bool>(() => super.canSubmit, name: '_VerifyStore.canSubmit'))
      .value;

  final _$responseAtom = Atom(name: '_VerifyStore.response');

  @override
  ObservableFuture<Response>? get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(ObservableFuture<Response>? value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  final _$statusAtom = Atom(name: '_VerifyStore.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$codeAtom = Atom(name: '_VerifyStore.code');

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

  final _$validateCodeAsyncAction = AsyncAction('_VerifyStore.validateCode');

  @override
  Future<dynamic> validateCode(String value) {
    return _$validateCodeAsyncAction.run(() => super.validateCode(value));
  }

  final _$_VerifyStoreActionController = ActionController(name: '_VerifyStore');

  @override
  Future<dynamic> doVerify(BuildContext context) {
    final _$actionInfo = _$_VerifyStoreActionController.startAction(
        name: '_VerifyStore.doVerify');
    try {
      return super.doVerify(context);
    } finally {
      _$_VerifyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
response: ${response},
status: ${status},
code: ${code},
canSubmit: ${canSubmit}
    ''';
  }
}

mixin _$FormVerifyErrorState on _FormVerifyErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormVerifyErrorState.hasErrors'))
          .value;

  final _$codeAtom = Atom(name: '_FormVerifyErrorState.code');

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  @override
  String toString() {
    return '''
code: ${code},
hasErrors: ${hasErrors}
    ''';
  }
}
