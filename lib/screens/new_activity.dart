import 'dart:convert';

import 'package:event/model/ArgumentNewActivity.dart';
import 'package:event/services/consts.dart';
import 'package:event/stores/new_activity_store.dart';
import 'package:event/stores/new_activity_store.dart';
import 'package:event/stores/new_visitor_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/circle_button.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/json_schema.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NewActivity extends StatelessWidget {
  NewActivityStore store;
  String formString = json.encode({
    'autoValidated': false,
    'fields': [
      {
        "id": 6,
        "name": "license",
        "label": "License",
        "type": "text",
        "placeholder": "",
        "value": "SIMA",
        "items": null,
        "required": 1
      },
      {
        "id": 7,
        "name": "product",
        "label": "Product",
        "type": "select",
        "placeholder": "",
        "value": "Tesla",
        "items": [
          {
            "label": "tesla",
            "value": "Tesla"
          },
          {
            "label": "ferrari",
            "value": "Ferrari"
          },
          {
            "label": "mini-cooper",
            "value": "Mini Cooper"
          }
        ],
        "required": 1
      },
      {
        "id": 8,
        "name": "salesman",
        "label": "Salesman",
        "type": "text",
        "placeholder": "",
        "value": "Taufik",
        "items": null,
        "required": 1
      }
    ]
  });

  dynamic response;

  String validationExample(field, value) {
    if (value.isEmpty) {
      return 'Please enter some text.test';
    }
    return null;
  }

  Map validations;
  Map decorations = {
    'email': InputDecoration(
      hintText: 'Email',
      prefixIcon: Icon(Icons.email),
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
    'username': InputDecoration(
      labelText: "Enter your email",
      prefixIcon: Icon(Icons.account_box),
      border: OutlineInputBorder(),
    ),
    'password1': InputDecoration(prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
  };

  NewActivity( {ArgumentNewActivity arguments}) {
    store = NewActivityStore();
    store.activity=arguments.activity;
    store.visitor=arguments.visitor;
    store.isEdit=arguments.isEdit;
    store.activityHistory=arguments.activityHistory;
    print(store.visitor["id"]);
    store.getRegisterEntity();



    validations = {
      'name': validationExample,
    };
    //print('formString:' + formString);
  }

  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      darkMode: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Container(child: Observer(builder: (_) {
                if (null != store.entity && null!=store.formString && store.formString.length>0) {
                  return Column(children: [
                    SizedBox(
                      width: double.infinity,
                      height: 65,
                    ),
                    Expanded(
                      child: Observer(
                          builder: (_) => JsonSchema(
                              //validations: validations,
                              //decorations: decorations,
                              padding: 0,
                              form: store.formString,
                              onChanged: (dynamic response) {
                                this.response = response;
                                print("Form:" + response.toString());
                              },
                              actionSave: (data) {
                                FocusScope.of(context).unfocus();
                                print('Submit:' + store.responseSubmit.toString());
                                //store.submitNewUser(data);
                                //{"status":true,"message":"success register visitor activity",
                                // "data":{"id":4,"name":"Test Drive","category":"Test Drive","license":"SIM1","product":"Tesla","salesman":"Yk","created_at":"2020-12-22T09:55:54.000000Z"}}
                                store.submitNewActivity(data).then((response) {
                                  print(response);
                                  response = json.decode(response);
                                  print(response["data"]["name"]);
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: store.visitor["name"] + " successfully added to "+response["data"]["name"],
                                          text: "Home",
                                          text2: "Back",
                                          buttonColor1: Colors.white,
                                          buttonColor2: redColor,
                                          textColor1: redColor,
                                          textColor2: Colors.white,
                                          function: () {
                                            //print('Bisa custom');

                                            Navigator.of(context)
                                                .pushNamed(homePageRoute);
                                          },
                                          function2:(){
                                            Navigator.of(context).pop();
                                          }
                                        );
                                      }
                                      );
                                });
                              },
                              buttonSave: SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFBA1134), borderRadius: BorderRadius.all(Radius.circular(8))),
                                    child: Center(
                                      child: Observer(
                                        builder: (_) {
                                          if (!store.isSubmit) {
                                            return Text("Save",
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                                          } else {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Please Wait",
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  )))),
                    ),
                    Observer(builder: (_) {
                      if (store.responseSubmit == null) {
                        return Container();
                      } else
                        return Text('' + store.responseSubmit.status.toString());
                    }),
                  ]);
                }
                if(null==store.formString || store.formString.length==0){
                  return Container();
                }
                return Positioned.fill(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 65,
                            ),
                            LightShimmer(width: 100, height: 16),
                            SizedBox(
                              height: 8,
                            ),
                            LightShimmer(width: double.infinity, height: 55),
                            SizedBox(
                              height: 20,
                            ),
                            LightShimmer(width: 100, height: 16),
                            SizedBox(
                              height: 8,
                            ),
                            LightShimmer(width: double.infinity, height: 55),
                            SizedBox(
                              height: 20,
                            ),
                            LightShimmer(width: 100, height: 16),
                            SizedBox(
                              height: 8,
                            ),
                            LightShimmer(width: double.infinity, height: 55),
                            SizedBox(
                              height: 20,
                            ),
                            LightShimmer(width: 100, height: 16),
                            SizedBox(
                              height: 8,
                            ),
                            LightShimmer(width: double.infinity, height: 55),
                            SizedBox(
                              height: 20,
                            ),
                            LightShimmer(width: 100, height: 16),
                            SizedBox(
                              height: 8,
                            ),
                            LightShimmer(width: double.infinity, height: 55),
                            SizedBox(
                              height: 20,
                            ),
                            LightShimmer(width: 100, height: 16),
                            SizedBox(
                              height: 8,
                            ),
                            LightShimmer(width: double.infinity, height: 55),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )));
              })),
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        CircleButton(
                          child: Image(image: AssetImage('assets/images/back.png')),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text(store.activity.name, textAlign: TextAlign.center, style: kTextTitleDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
