import 'package:event/model/arguments_notification.dart';
import 'package:event/services/consts.dart';
import 'package:event/stores/notification_detail_store.dart';
import 'package:event/widgets/black_theme.dart';
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
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1))),
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        width: ScreenUtil().setSp(60),
                                        child: Observer(builder: (_) {
                                          if (store.isNotificationDetailReady) {
                                            return Image.network(
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
                                            );
                                          }
                                          return const LightShimmer(
                                              height: 48,
                                              width: double.infinity);
                                        })),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(child: Observer(
                                      builder: (_) {
                                        if (store.isNotificationDetailReady) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                store.notification?.data?.sender
                                                        ?.name ??
                                                    '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: darkBackground),
                                              ),
                                              Text(
                                                DateFormat(
                                                        'dd MMM yyyy | HH:mm')
                                                    .format(DateTime.parse(store
                                                        .notification!
                                                        .data!
                                                        .createdAt!)),
                                                style: const TextStyle(
                                                    color: darkBackground),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        Observer(builder: (_) {
                                                      if (store
                                                          .isNotificationDetailReady) {
                                                        {
                                                          List recipients =
                                                              store
                                                                  .notification!
                                                                  .recipients!
                                                                  .map((e) =>
                                                                      e.name)
                                                                  .toList();

                                                          return Text(
                                                              'to: ' +
                                                                  recipients
                                                                      .join(
                                                                          ', '),
                                                              style: const TextStyle(
                                                                  color:
                                                                      darkBackground));
                                                        }
                                                      }

                                                      return const Text('');
                                                    }),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        }

                                        return const LightShimmer(
                                            height: 48, width: double.infinity);
                                      },
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Observer(builder: (_) {
                                  if (store.isNotificationDetailReady) {
                                    return Text(
                                      store.notification?.data?.message ?? '',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(14),
                                          color: Colors.grey[700]),
                                    );
                                  }
                                  return const LightShimmer(
                                      height: 100, width: double.infinity);
                                }),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ReplyField(type: widget.arguments.type)
              ],
            ),
          )),
    );
  }
}

class Reply extends StatelessWidget {
  const Reply({Key? key, required Reply reply}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  width: ScreenUtil().setSp(60),
                  child: Image(
                    image: AssetImage('assets/images/app_icon.png'),
                  )),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Crew Wuling",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: darkBackground),
                    ),
                    Row(
                      children: [
                        Text(
                          "31 Aug 2020",
                          style: TextStyle(color: darkBackground),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "|",
                          style: TextStyle(color: darkBackground),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "21:00",
                          style: TextStyle(color: darkBackground),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "ok mantap",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), color: Colors.grey[700]),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class ReplyField extends StatelessWidget {
  const ReplyField({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    if (type == 'announcement') {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomInput(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Reply.."),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          FlatButton(
              child: Image(image: AssetImage('assets/images/send.png')),
              shape: CircleBorder(),
              color: redColor,
              minWidth: 0,
              padding: EdgeInsets.all(16),
              onPressed: () {
                print("asd");
              }),
        ],
      ),
    );
  }
}
