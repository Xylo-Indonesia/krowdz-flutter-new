// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VersionStore on _VersionStore, Store {
  Computed<bool>? _$isLatestComputed;

  @override
  bool get isLatest => (_$isLatestComputed ??=
          Computed<bool>(() => super.isLatest, name: '_VersionStore.isLatest'))
      .value;

  final _$versionServerAtom = Atom(name: '_VersionStore.versionServer');

  @override
  Version? get versionServer {
    _$versionServerAtom.reportRead();
    return super.versionServer;
  }

  @override
  set versionServer(Version? value) {
    _$versionServerAtom.reportWrite(value, super.versionServer, () {
      super.versionServer = value;
    });
  }

  final _$responseAtom = Atom(name: '_VersionStore.response');

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

  final _$currentVersionAtom = Atom(name: '_VersionStore.currentVersion');

  @override
  ObservableFuture<String>? get currentVersion {
    _$currentVersionAtom.reportRead();
    return super.currentVersion;
  }

  @override
  set currentVersion(ObservableFuture<String>? value) {
    _$currentVersionAtom.reportWrite(value, super.currentVersion, () {
      super.currentVersion = value;
    });
  }

  final _$_VersionStoreActionController =
      ActionController(name: '_VersionStore');

  @override
  Future<dynamic> fetchVersion() {
    final _$actionInfo = _$_VersionStoreActionController.startAction(
        name: '_VersionStore.fetchVersion');
    try {
      return super.fetchVersion();
    } finally {
      _$_VersionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> getCurrent() {
    final _$actionInfo = _$_VersionStoreActionController.startAction(
        name: '_VersionStore.getCurrent');
    try {
      return super.getCurrent();
    } finally {
      _$_VersionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
versionServer: ${versionServer},
response: ${response},
currentVersion: ${currentVersion},
isLatest: ${isLatest}
    ''';
  }
}
