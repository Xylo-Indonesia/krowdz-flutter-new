import 'dart:io';

import 'package:badges/badges.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:event/model/keymap.dart';
import 'package:event/services/consts.dart';
import 'package:event/stores/settings_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/circle_button.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/custom_dropdown.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/nav_button.dart';
import 'package:event/widgets/photo_list.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class SettingsPage extends StatefulWidget {
  late SettingsStore store;

  SettingsPage() {
    store = SettingsStore();
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedType = "";
  List imageList = [];

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(File(pickedFile!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      darkMode: true,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: CustomHeader(
                    onBack: () {
                      Navigator.pop(context);
                    },
                    darkMode: true,
                    title: "Settings",
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            clipBehavior: Clip.antiAlias,
                            child: Image(
                              image: AssetImage('assets/images/app_icon.png'),
                            ),
                            //  FadeInImage.memoryNetwork(
                            //   placeholder: kTransparentImage,
                            //   image: 'https://placehold.it/600',
                            //   fit: BoxFit.contain,
                            //   width: double.infinity,
                            // ),
                          ),
                          CustomInput(
                            label: "Name",
                            darkMode: true,
                            child: TextFormField(),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CustomInput(
                              label: "Language",
                              darkMode: true,
                              child: CustomDropdown(
                                itemList: [
                                  KeyMap('value', 'English'),
                                  KeyMap('value', 'Indonesia')
                                ],
                                onClick: (value) {
                                  print('selected: ' + value);
                                },
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          CustomInput(
                            darkMode: true,
                            label: "Add Photo",
                            child: Row(
                              children: [
                                FloatingActionButton(
                                  onPressed: pickImage,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: darkBackground,
                                    size: 24,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          color: darkerBackground, width: 1)),
                                ),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        radius: 2.5,
                        colors: [darkerBackground, Color(0xFF101010)],
                        center: Alignment.topCenter),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Observer(
                      builder: (_) => FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: "Are you sure want to log out?",
                                      text: "Yes",
                                      text2: "Back",
                                      buttonColor1: Colors.white,
                                      buttonColor2: redColor,
                                      textColor1: redColor,
                                      textColor2: Colors.white,
                                      function: () {
                                        widget.store.doLogout().then((status) {
                                          print('Logout:' + status);
                                          if ('true' == status)
                                            Navigator.pushReplacementNamed(
                                                context, loginPageRoute);
                                        });
                                      },
                                    );
                                  });
                            },
                            splashColor: Colors.white30,
                            highlightColor: Colors.white12,
                            child: Text("Log Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            padding: EdgeInsets.all(18),
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side:
                                    BorderSide(color: Colors.white, width: 1)),
                          )),
                ),
              ],
            ),
          )),
    );
  }
}
