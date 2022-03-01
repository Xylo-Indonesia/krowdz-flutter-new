import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationCreate extends StatefulWidget {
  const NotificationCreate({Key? key}) : super(key: key);

  @override
  State<NotificationCreate> createState() => _NotificationCreateState();
}

class _NotificationCreateState extends State<NotificationCreate> {
  String title = '';
  String message = '';
  List<int> recipients = [];
  bool isAllUsers = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      darkMode: false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: CustomHeader(
                    darkMode: false,
                    title: 'General',
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Subject',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16))),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: "Enter subject...",
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: redColor, width: 1))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a subject.';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  title = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text('Send To',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16))),
                            const SizedBox(
                              height: 24,
                            ),
                            Text('Message',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(16))),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomInput(
                              child: TextFormField(
                                maxLines: 20,
                                decoration: const InputDecoration(
                                    hintText: "Enter message...",
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: redColor, width: 1))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a subject.';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  title = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(100),
                    child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 32),
                          child: TextButton(
                              child: Text('Send',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(redColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)))),
                              onPressed: () {
                                print("send");
                              }),
                        )))
              ],
            ),
          )),
    );
  }
}
