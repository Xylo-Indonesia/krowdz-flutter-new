import 'dart:convert';

import 'package:event/model/response.dart';
import 'package:event/model/version.dart';
import 'package:event/services/http_request.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';

part 'version_store.g.dart';

class VersionStore = _VersionStore with _$VersionStore;

abstract class _VersionStore with Store {
  final API httpClient = API();

  @observable
  Version versionServer;

  @observable
  ObservableFuture<Response> response;

  @observable
  ObservableFuture<String> currentVersion;

  @action
  Future fetchVersion() => response = ObservableFuture(httpClient
      .getVersion()
      .then(
          (response) {
            print (response);
            Response myResponse = Response.fromJson(json.decode(response));
              //print("Status:"+myResponse.status);
              if ("true" == myResponse.status) {
                versionServer =Version.fromJson(myResponse.data);
              }
            return myResponse;
          }
      )
      .catchError((e){
        print(e);
      })
  );

  @action
  Future getCurrent()=>
    currentVersion=
        ObservableFuture(PackageInfo.fromPlatform()).then((PackageInfo packageInfo) {
        String appName = packageInfo.appName;
        String packageName = packageInfo.packageName;
        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;
        return version;
      });

  void getThePosts() {
    fetchVersion();
  }

  @computed
  bool get isLatest{
    List<String> list_cur=currentVersion.value.split(".");
    List<String> list_server=versionServer.latestVersion.split('.');
    if(list_server[0].compareTo(list_cur[0])==0)
      if(list_server[1].compareTo(list_cur[1])==0)
        return true;

    return false;
  }
}
