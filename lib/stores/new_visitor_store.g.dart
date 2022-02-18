// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_visitor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewVisitor on _NewVisitor, Store {
  final _$entityAtom = Atom(name: '_NewVisitor.entity');

  @override
  Entity? get entity {
    _$entityAtom.reportRead();
    return super.entity;
  }

  @override
  set entity(Entity? value) {
    _$entityAtom.reportWrite(value, super.entity, () {
      super.entity = value;
    });
  }

  final _$formStringAtom = Atom(name: '_NewVisitor.formString');

  @override
  String? get formString {
    _$formStringAtom.reportRead();
    return super.formString;
  }

  @override
  set formString(String? value) {
    _$formStringAtom.reportWrite(value, super.formString, () {
      super.formString = value;
    });
  }

  final _$responseSubmitAtom = Atom(name: '_NewVisitor.responseSubmit');

  @override
  ObservableFuture<dynamic>? get responseSubmit {
    _$responseSubmitAtom.reportRead();
    return super.responseSubmit;
  }

  @override
  set responseSubmit(ObservableFuture<dynamic>? value) {
    _$responseSubmitAtom.reportWrite(value, super.responseSubmit, () {
      super.responseSubmit = value;
    });
  }

  final _$isSubmitAtom = Atom(name: '_NewVisitor.isSubmit');

  @override
  bool get isSubmit {
    _$isSubmitAtom.reportRead();
    return super.isSubmit;
  }

  @override
  set isSubmit(bool value) {
    _$isSubmitAtom.reportWrite(value, super.isSubmit, () {
      super.isSubmit = value;
    });
  }

  final _$submitNewUserAsyncAction = AsyncAction('_NewVisitor.submitNewUser');

  @override
  Future<dynamic> submitNewUser(dynamic data) {
    return _$submitNewUserAsyncAction.run(() => super.submitNewUser(data));
  }

  @override
  String toString() {
    return '''
entity: ${entity},
formString: ${formString},
responseSubmit: ${responseSubmit},
isSubmit: ${isSubmit}
    ''';
  }
}
