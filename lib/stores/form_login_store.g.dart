// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormLoginStore on _FormLoginStore, Store {
  Computed<bool>? _$isUserCheckPendingComputed;

  @override
  bool get isUserCheckPending => (_$isUserCheckPendingComputed ??=
          Computed<bool>(() => super.isUserCheckPending,
              name: '_FormLoginStore.isUserCheckPending'))
      .value;
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_FormLoginStore.canLogin'))
          .value;

  final _$url_logoAtom = Atom(name: '_FormLoginStore.url_logo');

  @override
  String? get url_logo {
    _$url_logoAtom.reportRead();
    return super.url_logo;
  }

  @override
  set url_logo(String? value) {
    _$url_logoAtom.reportWrite(value, super.url_logo, () {
      super.url_logo = value;
    });
  }

  final _$clientAtom = Atom(name: '_FormLoginStore.client');

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

  final _$colorAtom = Atom(name: '_FormLoginStore.color');

  @override
  CustomColor? get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(CustomColor? value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$nameAtom = Atom(name: '_FormLoginStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_FormLoginStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormLoginStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$usernameCheckAtom = Atom(name: '_FormLoginStore.usernameCheck');

  @override
  ObservableFuture<bool?> get usernameCheck {
    _$usernameCheckAtom.reportRead();
    return super.usernameCheck;
  }

  @override
  set usernameCheck(ObservableFuture<bool?> value) {
    _$usernameCheckAtom.reportWrite(value, super.usernameCheck, () {
      super.usernameCheck = value;
    });
  }

  final _$validateEmailAsyncAction =
      AsyncAction('_FormLoginStore.validateEmail');

  @override
  Future<dynamic> validateEmail(String value) {
    return _$validateEmailAsyncAction.run(() => super.validateEmail(value));
  }

  final _$_FormLoginStoreActionController =
      ActionController(name: '_FormLoginStore');

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormLoginStoreActionController.startAction(
        name: '_FormLoginStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormLoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
url_logo: ${url_logo},
client: ${client},
color: ${color},
name: ${name},
email: ${email},
password: ${password},
usernameCheck: ${usernameCheck},
isUserCheckPending: ${isUserCheckPending},
canLogin: ${canLogin}
    ''';
  }
}

mixin _$FormLoginErrorState on _FormLoginErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormLoginErrorState.hasErrors'))
          .value;

  final _$usernameAtom = Atom(name: '_FormLoginErrorState.username');

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$emailAtom = Atom(name: '_FormLoginErrorState.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormLoginErrorState.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  @override
  String toString() {
    return '''
username: ${username},
email: ${email},
password: ${password},
hasErrors: ${hasErrors}
    ''';
  }
}
