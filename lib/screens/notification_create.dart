import 'package:event/services/consts.dart';
import 'package:event/stores/dashboard_store.dart';
import 'package:event/stores/notification_create_store.dart';
import 'package:event/model/notification_create.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NotificationCreate extends StatefulWidget {
  const NotificationCreate({Key? key}) : super(key: key);

  @override
  State<NotificationCreate> createState() => _NotificationCreateState();
}

class _NotificationCreateState extends State<NotificationCreate> {
  final DashboardStore dashboardStore = DashboardStore();
  NotificationCreateStore store = NotificationCreateStore();

  String title = '';
  String message = '';
  List recipients = [];
  bool isAllUsers = false;

  bool hasValidationErrors = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    dashboardStore.getUser();
    store.getUsersList();
  }

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
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Observer(builder: (_) {
                              if (!store.isUsersListReady) {
                                return const LightShimmer(
                                    height: 48, width: double.infinity);
                              }

                              return Column(
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
                                                    color: redColor,
                                                    width: 1))),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a subject.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          title = value;
                                        },
                                      ),
                                    )
                                  ]);
                            }),
                            const SizedBox(
                              height: 24,
                            ),
                            Observer(builder: (_) {
                              if (!store.isUsersListReady) {
                                return const LightShimmer(
                                    height: 125, width: double.infinity);
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Send To',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(16))),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  if (!isAllUsers)
                                    MultiSelectDialogField(
                                      title: const Text("Select Recipients"),
                                      items: store.users.data
                                          .map(
                                              (e) => MultiSelectItem(e, e.name))
                                          .toList(),
                                      searchable: true,
                                      searchHint: 'Recipient name...',
                                      listType: MultiSelectListType.LIST,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: hasValidationErrors
                                                  ? redColor
                                                  : Colors.black,
                                              width: 1)),
                                      buttonText:
                                          const Text("Select Recipients"),
                                      buttonIcon: const Icon(null),
                                      initialValue: recipients,
                                      validator: (values) {
                                        if ((values == null ||
                                                values.isEmpty) &&
                                            !isAllUsers) {
                                          return 'Please select at least one user.';
                                        }
                                        return null;
                                      },
                                      onConfirm: (values) {
                                        recipients = values;
                                      },
                                    ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(children: [
                                    Checkbox(
                                      activeColor: redColor,
                                      checkColor: Colors.white,
                                      value: isAllUsers,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isAllUsers = value!;
                                        });
                                      },
                                    ),
                                    Text('All Users',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(16))),
                                  ]),
                                ],
                              );
                            }),
                            const SizedBox(
                              height: 12,
                            ),
                            Observer(builder: (_) {
                              if (!store.isUsersListReady) {
                                return const LightShimmer(
                                    height: 400, width: double.infinity);
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Message',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(16))),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomInput(
                                    child: TextFormField(
                                      maxLines: 18,
                                      decoration: const InputDecoration(
                                          hintText: "Enter message...",
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: redColor, width: 1))),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a message.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        message = value;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  if (!dashboardStore.isUserReady ||
                      dashboardStore.user?.data?.role != 'supervisor') {
                    return Container();
                  }

                  return SizedBox(
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
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      hasValidationErrors = false;
                                    });

                                    var tempRecipients = recipients;
                                    recipients =
                                        recipients.map((e) => e.id).toList();

                                    var createStatus =
                                        await store.createGeneralNotification(
                                            title,
                                            message,
                                            isAllUsers,
                                            recipients);

                                    if (createStatus != 200) {
                                      String errorMessage = '';

                                      switch (createStatus) {
                                        case 403:
                                          errorMessage =
                                              'You do not have permission to send notifications.';
                                          break;

                                        default:
                                          errorMessage = 'An error occurred.';
                                          break;
                                      }

                                      showDialog(
                                        context: context,
                                        barrierColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: errorMessage,
                                            text: "Back",
                                            buttonColor2: Colors.white,
                                            buttonColor1: redColor,
                                            textColor2: redColor,
                                            textColor1: Colors.white,
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        barrierColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                              title: "Discussion created.",
                                              text: "Back",
                                              buttonColor2: Colors.white,
                                              buttonColor1: redColor,
                                              textColor2: redColor,
                                              textColor1: Colors.white,
                                              function: () {
                                                Navigator.of(context).pop();
                                              });
                                        },
                                      );
                                    }

                                    recipients = tempRecipients;
                                  } else {
                                    setState(() {
                                      hasValidationErrors = true;
                                    });
                                  }
                                }),
                          )));
                })
              ],
            ),
          )),
    );
  }
}
