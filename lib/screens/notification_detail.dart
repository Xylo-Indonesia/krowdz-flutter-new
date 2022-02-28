import 'package:event/model/arguments_notification.dart';
import 'package:event/model/notification_detail.dart';
import 'package:event/services/consts.dart';
import 'package:event/stores/notification_detail_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class NotificationDetail extends StatefulWidget {
  final ArgumentsNotification arguments;

  const NotificationDetail({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  NotificationDetailStore store = NotificationDetailStore();

  @override
  void initState() {
    super.initState();

    final id = widget.arguments.id;

    if (widget.arguments.type == 'general') {
      store.getGeneralNotificationDetail(id);
    } else {
      store.getAnnouncementDetail(id);
    }
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
                    title: toBeginningOfSentenceCase(widget.arguments.type),
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                          ),
                          Observer(builder: (_) {
                            if (store.isNotificationDetailReady) {
                              return Text(store.notification?.data?.title ?? '',
                                  style: kTextTitleDark);
                            }
                            return const LightShimmer(
                                height: 24, width: double.infinity);
                          }),
                          const SizedBox(
                            height: 8,
                          ),
                          Observer(builder: (_) {
                            if (store.isNotificationDetailReady) {
                              return MessageItem(
                                  isReady: true,
                                  store: store,
                                  isParent: true,
                                  sender:
                                      store.notification!.data!.sender!.name!,
                                  message: store.notification!.data!.message!,
                                  recipients: store.notification!.recipients!,
                                  createdAt:
                                      store.notification!.data!.createdAt!);
                            }

                            return MessageItem(
                                isReady: false,
                                store: store,
                                sender: '',
                                message: '',
                                recipients: const [],
                                createdAt: '',
                                isParent: true);
                          }),
                          Observer(builder: (_) {
                            if (store.isNotificationDetailReady &&
                                store.notification!.replies!.isNotEmpty) {
                              return Column(children: [
                                for (Reply reply
                                    in store.notification!.replies!)
                                  MessageItem(
                                      isReady: true,
                                      store: store,
                                      isParent: false,
                                      sender: reply.sender!.name,
                                      message: reply.message,
                                      createdAt: reply.createdAt)
                              ]);
                            }
                            return Container();
                          })
                        ],
                      ),
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  if (store.isNotificationDetailReady &&
                      widget.arguments.type == 'general') {
                    return ReplyField(
                        store: store, notificationId: widget.arguments.id);
                  }

                  return Container();
                })
              ],
            ),
          )),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.isReady,
    required this.store,
    required this.isParent,
    this.sender,
    this.message,
    this.recipients,
    this.createdAt,
  }) : super(key: key);

  final bool isReady;
  final NotificationDetailStore store;
  final String? sender;
  final String? message;
  final List<User>? recipients;
  final String? createdAt;
  final bool isParent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    width: ScreenUtil().setSp(60),
                    child: isReady
                        ? Image.network(
                            store.notification!.companyLogo!,
                            errorBuilder: (
                              context,
                              object,
                              stacktrace,
                            ) {
                              return Image.asset(
                                'assets/images/app_icon.png',
                              );
                            },
                          )
                        : const LightShimmer(
                            height: 48, width: double.infinity)),
                const SizedBox(
                  width: 8,
                ),
                isReady
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sender ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkBackground),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy | HH:mm')
                                  .format(DateTime.parse(createdAt ?? '')),
                              style: const TextStyle(color: darkBackground),
                            ),
                            if (isParent)
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          'to: ' +
                                              recipients!
                                                  .map((e) => e.name)
                                                  .toList()
                                                  .join(', '),
                                          style: const TextStyle(
                                              color: darkBackground)))
                                ],
                              ),
                          ],
                        ),
                      )
                    : const Expanded(
                        child: LightShimmer(height: 48, width: double.infinity))
              ]),
          const SizedBox(
            height: 8,
          ),
          isReady
              ? Text(
                  message ?? '',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.grey[700]),
                )
              : const LightShimmer(height: 100, width: double.infinity),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class ReplyField extends StatefulWidget {
  const ReplyField(
      {Key? key, required this.store, required this.notificationId})
      : super(key: key);

  final NotificationDetailStore store;
  final String notificationId;

  @override
  State<ReplyField> createState() => _ReplyFieldState();
}

class _ReplyFieldState extends State<ReplyField> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomInput(
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Reply.."),
                onChanged: (value) {
                  message = value;
                },
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          TextButton(
              child: const Image(image: AssetImage('assets/images/send.png')),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(redColor),
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16))),
              onPressed: () async {
                var replyStatus = await widget.store.replyGeneralNotification(
                    widget.store.notification!.data!.id!, message);

                if (replyStatus == false) {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return const CustomDialogBox(
                        title: "An error occurred when replying to discussion.",
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
                          title: "Reply Sent!",
                          text: "Back",
                          buttonColor2: Colors.white,
                          buttonColor1: redColor,
                          textColor2: redColor,
                          textColor1: Colors.white,
                          function: () {
                            widget.store.getGeneralNotificationDetail(
                                widget.notificationId);
                          });
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}
