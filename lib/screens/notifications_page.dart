import 'package:badges/badges.dart';
import 'package:event/stores/notification_list_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/notification_item.dart';
import 'package:event/widgets/notification_item_general.dart';
import 'package:event/widgets/notification_type.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event/services/consts.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationListStore store = NotificationListStore();

  _NotificationsState() {
    store.getGeneralNotifications();
    store.getAnnouncements();
  }

  var testArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  String listType = 'general';

  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      darkMode: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("add");
          },
          icon: Icon(Icons.add),
          label: Text("New Discussion"),
          backgroundColor: redColor,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                child: CustomHeader(
                  darkMode: true,
                  onBack: () => Navigator.of(context).pop(),
                  title: "Notifications",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: [
                    NotificationType(
                      isActive: listType == 'announcement' ? true : false,
                      title: "Announcement",
                      onTap: () {
                        setState(() {
                          listType = 'announcement';
                        });
                      },
                      badge: Badge(
                        showBadge: true,
                        padding: EdgeInsets.all(4),
                        position: BadgePosition(top: 0, end: 0),
                        badgeColor: redColor,
                        badgeContent: Observer(builder: (_) {
                          if (store.announcements?.meta != null) {
                            return Text(
                              store.announcements?.meta?.unreadCount
                                      .toString() ??
                                  '0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(14)),
                            );
                          }
                          return Container();
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    NotificationType(
                        isActive: listType == 'general' ? true : false,
                        title: "Discussion",
                        onTap: () {
                          setState(() {
                            listType = 'general';
                          });
                        },
                        badge: Badge(
                          showBadge: true,
                          padding: EdgeInsets.all(4),
                          position: BadgePosition(top: 0, end: 0),
                          badgeColor: redColor,
                          badgeContent: Observer(builder: (_) {
                            if (store.general?.meta != null) {
                              return Text(
                                store.general?.meta?.unreadCount.toString() ??
                                    '0',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14)),
                              );
                            }
                            return Container();
                          }),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 32),
                    child: Observer(builder: (_) {
                      if (listType == 'general' &&
                          store.general?.data != null) {
                        print('general');

                        return Column(
                          children: [
                            for (var item in store.general!.data!)
                              NotificationItem(
                                title: item.title,
                                message: item.message,
                                isUnread: item.readAt == null,
                              ),
                          ],
                        );
                      } else if (listType == 'announcement' &&
                          store.announcements?.data != null) {
                        print('announcement');
                        return Column(
                          children: [
                            for (var item in store.announcements!.data!)
                              NotificationItem(
                                title: item.title,
                                message: item.message,
                                isUnread: item.readAt == null,
                              ),
                          ],
                        );
                      } else {
                        return Column();
                      }
                    }),
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
