import 'dart:async';

import 'package:code_field/code_field.dart';
import 'package:event/model/client.dart';
import 'package:event/model/version.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/response_dialogs.dart';
import 'package:event/stores/verify_store.dart';
import 'package:event/stores/version_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_number.dart';
import 'package:event/widgets/custom_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartupPage extends StatelessWidget {
  final VersionStore store = VersionStore();
  final VerifyStore verify_store = VerifyStore();
  final code_control = InputCodeControl(inputRegex: '^[0-9]*');

  StartupPage() {
    store.getThePosts();
    store.getCurrent();

    // reaction((_) => store.response.status,  (v) {
    //     print('New status: $v');
    //     Version version = store.versionServer;
    //     String currentVersion = store.currentVersion.value;
    //     var isLatest = currentVersion.compareTo(version.latestVersion);
    //     if (isLatest == 0) {
    //       var box=Hive.box<Client>('client');
    //       print("Hive startup: "+box.toString()+box.isEmpty.toString());
    //       if (box.length > 0) {
    //         Navigator.pushReplacementNamed(, loginPageRoute);
    //         print("Box Client more than 1");
    //       }
    //     }
    //
    //   }
    // );
  }

  @override
  Widget build(BuildContext context) {
    //listens to pin inputs
    code_control.addListener(() {
      if (code_control.value.length >= 6) {
        //if the pin is successfully inputted
        print(code_control.value);
        verify_store.code = code_control.value;

        verify_store.validateAll(context);
      } else {
        verify_store.error.code = "";
      }
    });

    return BlackTheme(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Observer(builder: (_) {
              switch (store.response!.status) {
                case FutureStatus.pending:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        Text(
                          'Version checking...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                case FutureStatus.rejected:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Failed',
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                        ),
                        RaisedButton(
                          child: const Text('Tap to try again'),
                          onPressed: _refresh,
                        )
                      ],
                    ),
                  );
                case FutureStatus.fulfilled:
                  //Version version=Version.fromJson(json.decode(store.response.value));
                  Version version = store.versionServer!;
                  String currentVersion = store.currentVersion!.value!;
                  var isLatest =
                      currentVersion.compareTo(version.latestVersion!);
                  if (isLatest == 0) {
                    var box = Hive.box<Client>('client');
                    print("Hive startup: " +
                        box.toString() +
                        box.isEmpty.toString());
                    if (box.length > 0) {
                      //return Text("");
                      //Navigator.pushReplacementNamed(context, loginPageRoute);
                      Timer(Duration(milliseconds: 100), () {
                        print(
                            "Yeah, this line is printed after 100 mili seconds");
                        Navigator.pushReplacementNamed(context, loginPageRoute);
                      });
                      print("Box Client more than 1");
                      return Container();
                    }
                    // else{
                    //
                    // }
                    //  if (box.length > 0) {
                    //    Navigator.pushReplacementNamed(context, loginPageRoute);
                    //    print("Box Client more than 1");
                    //
                    //  }

                    // return AlertDialog(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(10))),
                    //   content: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 32),
                    //         child: Text(
                    //           "App version " +
                    //             currentVersion +
                    //             "\n" +
                    //             "Input your client code:",
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //       Observer(
                    //         builder: (_) => TextFormField(
                    //           decoration: InputDecoration(
                    //             errorText: verify_store.error.code,
                    //             hintText: 'Client code',
                    //             border: OutlineInputBorder()),
                    //           textAlign: TextAlign.center,
                    //           keyboardType: TextInputType.text,
                    //           onChanged: (value) => verify_store.code = value,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: double.infinity,
                    //         child: FlatButton(
                    //           color: Theme.of(context).primaryColor,
                    //           textColor: Colors.white,
                    //           onPressed: () {
                    //             //var code=
                    //             verify_store.validateAll(context);
                    //           },
                    //           child: Text("VERIFY")),
                    //       ),
                    //     ],
                    //   ),
                    // );

                    return Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image(
                                image: AssetImage('assets/images/xylo.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 48),
                            child: Column(
                              children: [
                                Text(
                                  "Enter Your Company Code",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20.sp),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: Observer(
                                    builder: (_) => InputCodeField(
                                      control: code_control,
                                      count: 6,
                                      inputType: TextInputType.number,
                                      enabled: false,
                                      itemBuilder: (context, index) =>
                                          CustomPin(
                                        char: code_control[index],
                                      ),
                                      spacing: 20,
                                    ),
                                  ),
                                ),
                                Observer(
                                  builder: (_) => Text(
                                    (verify_store.error.hasErrors
                                        ? verify_store.error.code!
                                        : ""),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red,
                                        fontSize: 14.sp),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 32)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNumber(
                                      char: '1',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '2',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '3',
                                      codeControl: code_control,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNumber(
                                      char: '4',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '5',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '6',
                                      codeControl: code_control,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNumber(
                                      char: '7',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '8',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '9',
                                      codeControl: code_control,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNumber(
                                      type: 'empty',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      char: '0',
                                      codeControl: code_control,
                                    ),
                                    CustomNumber(
                                      type: 'delete',
                                      codeControl: code_control,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  //              return ResponseDialog.showVersionDialog(context, "You have latest version. \nPress confirm to continue", (){
                  //                Navigator.pushReplacementNamed(context, loginPageRoute);
                  //              });

                  return ResponseDialog.showVersionDialog(
                      context,
                      "Latest version:" +
                          version.latestVersion! +
                          ".\n" +
                          "Your version is : " +
                          currentVersion +
                          ".\n"
                              " Please update your app", () {
                    //Navigator.pop(context);
                    launchURLUpdate();
                  });

//            return Center(
//                child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                  Text(
//                    'Server Version:' + version.latestVersion,
//                    style: TextStyle(color: Colors.red, fontSize: 16),textAlign: TextAlign.center,
//                  ),
//                      Text(
//                        'App Version:' + currentVersion,
//                        style: TextStyle(color: Colors.red, fontSize: 16),textAlign: TextAlign.center,
//                      ),
//                  Text('Is Latest: '+store.isLatest.toString(),style: TextStyle(fontSize: 16),),
//                ]));
                default:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Version checking...'),
                      ],
                    ),
                  );
              }
            }),
          ),
        ),
      ),
    );
  }

  Future _refresh() => store.fetchVersion();

  static launchURLUpdate() async {
    const url = 'https://xylo.co.id';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
