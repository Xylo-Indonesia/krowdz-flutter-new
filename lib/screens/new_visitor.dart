import 'dart:convert';

import 'package:event/services/consts.dart';
import 'package:event/stores/new_visitor_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/circle_button.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/json_schema.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NewVisitorPage extends StatelessWidget {
  late NewVisitor store;
  String formString = json.encode({
    'autoValidated': false,
    'fields': [
      {
        "id": 1,
        "name": "name",
        "label": "Name",
        "type": "text",
        "placeholder": "Input your Name",
        "value": "",
        "items": null,
        "required": 1,
        "created_at": null,
        "updated_at": null
      },
      {
        "id": 2,
        "name": "gender",
        "label": "Gender",
        "type": "radio",
        "placeholder": "",
        "value": "",
        "items": [
          {"label": "Male", "value": "male"},
          {"label": "Female", "value": "female"}
        ],
        "required": 1,
        "created_at": null,
        "updated_at": null
      },
      {
        "id": 3,
        "name": "phone_number",
        "label": "Phone Number",
        "type": "text",
        "placeholder": "Input phone number",
        "value": "",
        "items": null,
        "required": 1,
        "created_at": null,
        "updated_at": null
      },
      {
        "id": 4,
        "name": "email",
        "label": "Email",
        "type": "text",
        "placeholder": "Input email",
        "value": "",
        "items": null,
        "required": 1,
        "created_at": null,
        "updated_at": null
      },
      {
        "id": 5,
        "name": "city",
        "label": "City",
        "type": "select",
        "placeholder": "",
        "value": null,
        "items": [
          {"label": "Medan", "value": "Medan"},
          {"label": "Aceh", "value": "Aceh"},
          {"label": "Jakarta", "value": "Jakarta"}
        ],
        "required": 1,
        "created_at": null,
        "updated_at": "2020-10-21T00:52:35.000000Z"
      }
    ]
  });

  dynamic response;

  String? validationExample(field, value) {
    if (value.isEmpty) {
      return 'Please enter some text.test';
    }
    return null;
  }

  Map? validations;
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
    'password1': InputDecoration(
        prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
  };

  NewVisitorPage() {
    store = NewVisitor();
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
                if (null != store.entity) {
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
                                print('Submit:' +
                                    store.responseSubmit.toString());
                                //store.submitNewUser(data);
                                store.submitNewUser(data).then((response) {
                                  print(response);
                                  response = json.decode(response);
                                  print(response["data"]["name"]);
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: response["data"]["name"] +
                                              " successfully added to Visitor List",
                                          text: "View Profile",
                                          text2: "Back",
                                          buttonColor1: Colors.white,
                                          buttonColor2: redColor,
                                          textColor1: redColor,
                                          textColor2: Colors.white,
                                          function: () {
                                            print('Bisa custom');

                                            Navigator.of(context).pushNamed(
                                                visitorDetailPage,
                                                arguments: response["data"]);
                                          },
                                        );
                                      });
                                });
                              },
                              buttonSave: SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFBA1134),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Center(
                                      child: Observer(
                                        builder: (_) {
                                          if (!store.isSubmit) {
                                            return Text("Add Visitor",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold));
                                          } else {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Please Wait",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))
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
                        return Text(
                            '' + store.responseSubmit!.status.toString());
                    }),
                  ]);
                }
                return Positioned.fill(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                          child: Image(
                              image: AssetImage('assets/images/back.png')),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text("Add New Visitor",
                                textAlign: TextAlign.center,
                                style: kTextTitleDark),
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
