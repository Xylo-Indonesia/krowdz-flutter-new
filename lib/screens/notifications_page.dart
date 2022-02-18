import 'package:badges/badges.dart';
import 'package:event/services/consts.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/notification_item.dart';
import 'package:event/widgets/notification_item_general.dart';
import 'package:event/widgets/notification_type.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          label: Text("New Thread"),
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
                          badgeContent: Text(
                            '20',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(14)),
                          )),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    NotificationType(
                      isActive: listType == 'general' ? true : false,
                      title: "General",
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
                          badgeContent: Text(
                            '2',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
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
                    child: Column(
                      children: testArray
                          .map((e) => listType == 'announcement'
                              ? NotificationItem(
                                  title: "Notification" + e.toString(),
                                  description:
                                      "This is notification " + e.toString(),
                                  isUnread: e < 5 ? true : false,
                                )
                              : NotificationItemGeneral(
                                  title: "Notification" + e.toString(),
                                  description:
                                      "This is notification " + e.toString(),
                                  dateString: '31 Nov 2020',
                                  timeString: '00:00',
                                  isUnread: e < 5 ? true : false,
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(notificationDetailPage),
                                ))
                          .toList(),
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
