library json_to_form;

import 'dart:convert';
import 'dart:io';

import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/photo_list.dart';
import 'package:event/widgets/styles.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JsonSchema extends StatefulWidget {
  const JsonSchema({
    required this.form,
    required this.onChanged,
    this.padding,
    this.formMap,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.buttonSave,
    this.actionSave,
  });

  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final String? form;
  final Map? formMap;
  final double? padding;
  final Widget? buttonSave;
  final Function? actionSave;
  final ValueChanged<dynamic> onChanged;

  @override
  _CoreFormState createState() =>
      new _CoreFormState(formMap ?? json.decode(form!));
}

class _CoreFormState extends State<JsonSchema> {
  final dynamic formGeneral;

  String? radioValue;

  // validators

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ??
          'Please fill ' + item['label'];
    }
    return null;
  }

  String? validateEmail(item, String value) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }

  bool labelHidden(item) {
    if (item.containsKey('hiddenLabel')) {
      if (item['hiddenLabel'] is bool) {
        return !item['hiddenLabel'];
      }
    } else {
      return true;
    }
    return false;
  }

  final picker = ImagePicker();
  List imageList = [];
  Future pickImage({var index}) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(File(pickedFile!.path));
      formGeneral['fields'][index]['value'] =
          base64Encode(File(pickedFile.path).readAsBytesSync());
    });
  }
  // Return widgets

  Widget jsonToForm() {
    List<Widget> listWidget = new List<Widget>();

    if (formGeneral['title'] != null) {
      listWidget.add(Text(
        formGeneral['title'],
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ));
    }
    if (formGeneral['description'] != null) {
      listWidget.add(Text(
        formGeneral['description'],
        style: new TextStyle(fontSize: 14.sp, fontStyle: FontStyle.italic),
      ));
    }

    for (var count = 0; count < formGeneral['fields'].length; count++) {
      Map item = formGeneral['fields'][count];

      if (item['type'] == "text" ||
          item['type'] == "number" ||
          item['type'] == "input" ||
          item['type'] == "password" ||
          item['type'] == "email" ||
          item['type'] == "textarea" ||
          item['type'] == "textinput") {
        // Widget label = SizedBox.shrink();
        // if (labelHidden(item)) {
        //   label = new Container(
        //     child: new Text(
        //       item['label'],
        //       style: new TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16.0,
        //           color: Colors.black),
        //     ),
        //   );
        // }

        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: new CustomInput(
              darkMode: false,
              label: labelHidden(item) ? item['label'] : null,
              child: TextFormField(
                controller: null,
                keyboardType:
                    item['name'] == "phone_number" || item['type'] == 'number'
                        ? TextInputType.number
                        : item['name'] == "email"
                            ? TextInputType.emailAddress
                            : TextInputType.text,
                initialValue: formGeneral['fields'][count]['value'] ?? null,
                decoration: item['decoration'] ??
                    widget.decorations[item['key']] ??
                    new InputDecoration(
                      hintText: item['placeholder'] ?? "",
                      //helperText: item['helpText'] ?? "",
                    ),
                maxLines: item['type'] == "TextArea" ? 10 : 1,
                onChanged: (String value) {
                  formGeneral['fields'][count]['value'] = value;
                  _handleChanged();
                },
                obscureText: item['type'] == "password" ? true : false,
                validator: (value) {
                  if (widget.validations.containsKey(item['key'])) {
                    return widget.validations[item['key']](item, value);
                  }
                  if (item.containsKey('validator')) {
                    if (item['validator'] != null) {
                      if (item['validator'] is Function) {
                        return item['validator'](item, value);
                      }
                    }
                  }
                  if (item['type'] == "email" || item['name'] == "Email") {
                    return validateEmail(item, value!);
                  }

                  if (item.containsKey('is_required')) {
                    if (item['is_required'] == 1 ||
                        item['is_required'] == true) {
                      return isRequired(item, value);
                    }
                  }

                  return null;
                },
              ),
            )));
      }

      if (item['type'] == "RadioButton" || item['type'] == 'radio') {
        List<Widget> radios = [];

        if (labelHidden(item)) {
          radios.add(new Text(
            item['label'],
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ));
        }
        radioValue = item['value'];
        for (var i = 0; i < item['items'].length; i++) {
          radios.add(
            new Theme(
              data: ThemeData(brightness: Brightness.light),
              child: Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(
                          formGeneral['fields'][count]['items'][i]['label'],
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                              color: Colors.black))),
                  new Radio<String?>(
                      activeColor: Colors.black,
                      value: formGeneral['fields'][count]['items'][i]['value'],
                      groupValue: radioValue,
                      onChanged: (String? value) {
                        this.setState(() {
                          radioValue = value;
                          formGeneral['fields'][count]['value'] = value;
                          _handleChanged();
                        });
                      })
                ],
              ),
            ),
          );
        }

        listWidget.add(
          new Container(
            margin: new EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: radios,
            ),
          ),
        );
      }

      if (item['type'] == "Switch") {
        if (item['value'] == null) {
          formGeneral['fields'][count]['value'] = false;
        }
        listWidget.add(
          new Container(
            margin: new EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: new Row(children: <Widget>[
              new Expanded(child: new Text(item['label'])),
              new Switch(
                value: item['value'] ?? false,
                onChanged: (bool value) {
                  this.setState(() {
                    formGeneral['fields'][count]['value'] = value;
                    _handleChanged();
                  });
                },
              ),
            ]),
          ),
        );
      }

      if (item['type'] == "Checkbox") {
        List<Widget> checkboxes = [];
        if (labelHidden(item)) {
          checkboxes.add(new Text(item['label'],
              style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)));
        }
        for (var i = 0; i < item['items'].length; i++) {
          checkboxes.add(
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text(
                        formGeneral['fields'][count]['items'][i]['label'])),
                new Checkbox(
                  value: formGeneral['fields'][count]['items'][i]['value'],
                  onChanged: (bool? value) {
                    this.setState(
                      () {
                        formGeneral['fields'][count]['items'][i]['value'] =
                            value;
                        _handleChanged();
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }

        listWidget.add(
          new Container(
            margin: new EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: checkboxes,
            ),
          ),
        );
      }

      if (item['type'] == "Select" || item['type'] == 'select') {
        Widget label = SizedBox.shrink();
        if (labelHidden(item)) {
          label = new Text(item['label'],
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black));
        }

        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomInput(
              label: item['label'],
              darkMode: false,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black)),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFFEDEDED),
                    hint: new Text("Select a " + item['label']),
                    value: formGeneral['fields'][count]['value'] != ''
                        ? formGeneral['fields'][count]['value'].toString()
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        formGeneral['fields'][count]['value'] = newValue;
                        _handleChanged();
                      });
                    },
                    items: item['items']
                        .map<DropdownMenuItem<String>>((dynamic data) {
                      return DropdownMenuItem<String>(
                        value: data['value'].toString(),
                        child: new Text(
                          data['label'],
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )));
      }

      if (item['type'] == "file") {
        listWidget.add(
          new Container(
              margin: new EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomInput(
                darkMode: false,
                label: "Add Photo",
                child: Row(
                  children: [
                    (imageList.isEmpty
                        ? FloatingActionButton(
                            onPressed: () {
                              pickImage(index: count);
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: darkBackground,
                              size: 24,
                            ),
                            backgroundColor: Colors.white,
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: darkerBackground, width: 1)),
                          )
                        : Container()),
                    SizedBox(width: 16),
                    Row(
                      children: imageList
                          .asMap()
                          .map((i, e) => MapEntry(
                              i,
                              PhotoList(
                                image: e,
                                onTap: () {
                                  setState(() {
                                    imageList.removeAt(i);
                                  });
                                },
                              )))
                          .values
                          .toList(),
                    )
                  ],
                ),
              )),
        );
      }
    }

    listWidget.add(SizedBox(
      height: 140,
    ));

    Stack col = Stack(children: [
      SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: listWidget,
            )),
      ),
    ]);

    if (widget.buttonSave != null) {
      //col.children.add(Spacer());
      col.children.add(new Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: Colors.black,
          child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                widget.actionSave!(formGeneral);
              }
            },
            child: widget.buttonSave,
          ),
        ),
      ));
    }
    return col;
  }

  _CoreFormState(this.formGeneral);

  void _handleChanged() {
    widget.onChanged(formGeneral);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      // autovalidate: formGeneral['autoValidated'] ?? false,
      key: _formKey,
      child: new Container(
        height: 650,
        padding: new EdgeInsets.all(widget.padding ?? 8.0),
        child: jsonToForm(),
        // new Column(
        //
        //   children: [jsonToForm()],
        // ),
      ),
    );
  }
}
