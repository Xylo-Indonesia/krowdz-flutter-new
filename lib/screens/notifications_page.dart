import 'package:badges/badges.dart';
import 'package:event/stores/notification_list_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/notification_item.dart';
import 'package:event/widgets/notification_item_general.dart';
import 'package:event/widgets/notification_type.dart';
import 'package:event/widgets/pagination.dart';
import 'package:event/widgets/pagination_number.dart';
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

    print(store.isAnnouncementsPageReady);
    print(store.isGeneralPageReady);
  }

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
          icon: const Icon(Icons.add),
          label: const Text("New Discussion"),
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
                        padding: const EdgeInsets.all(4),
                        position: const BadgePosition(top: 0, end: 0),
                        badgeColor: redColor,
                        badgeContent: Observer(builder: (_) {
                          if (store.isAnnouncementsPageReady) {
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
                    const SizedBox(
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
                          padding: const EdgeInsets.all(4),
                          position: const BadgePosition(top: 0, end: 0),
                          badgeColor: redColor,
                          badgeContent: Observer(builder: (_) {
                            if (store.isGeneralPageReady) {
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
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 32),
                    child: Observer(builder: (_) {
                      if (listType == 'general' && store.isGeneralPageReady) {
                        return Column(
                          children: [
                            for (var item in store.general!.data!)
                              NotificationItem(
                                title: item.title,
                                message: item.message,
                                isUnread: item.readAt == null,
                                type: 'general',
                                createdAt: item.createdAt,
                              ),
                            const SizedBox(height: 12),
                            GeneralPagination(store: store),
                          ],
                        );
                      } else if (listType == 'announcement' &&
                          store.isAnnouncementsPageReady) {
                        return Column(
                          children: [
                            for (var item in store.announcements!.data!)
                              NotificationItem(
                                title: item.title,
                                message: item.message,
                                isUnread: item.readAt == null,
                                type: 'announcement',
                                createdAt: item.createdAt,
                              ),
                            const SizedBox(height: 12),
                            AnnouncementsPagination(store: store)
                          ],
                        );
                      } else {
                        return Column();
                      }
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementsPagination extends StatelessWidget {
  const AnnouncementsPagination({
    Key? key,
    required this.store,
  }) : super(key: key);

  final NotificationListStore store;

  @override
  Widget build(BuildContext context) {
    return Pagination(
      hasNext: store.announcementsHasNext,
      hasPrev: store.announcementsHasPrev,
      pages: Row(
        children: [
          Observer(builder: (_) {
            var number = store.announcements!.meta!.currentPage!;
            var prevNumber = number - 2;
            if (prevNumber > 0) {
              return PaginationNumber(
                number: prevNumber,
                onTap: () {
                  print(prevNumber);
                  store.getAnnouncements(page: prevNumber.toString());
                },
                isSelected: false,
              );
            } else
              return Container();
          }),
          Observer(builder: (_) {
            var number = store.announcements!.meta!.currentPage!;
            var prevNumber = number - 1;
            if (prevNumber > 0) {
              return PaginationNumber(
                number: prevNumber,
                onTap: () {
                  print(prevNumber);
                  store.getAnnouncements(page: prevNumber.toString());
                },
                isSelected: false,
              );
            } else {
              return Container();
            }
          }),
          Observer(builder: (_) {
            return PaginationNumber(
              number: store.announcements!.meta!.currentPage,
              onTap: () {
                print(store.announcements!.meta!.currentPage);
              },
              isSelected: true,
            );
          }),
          Observer(builder: (_) {
            var number = store.announcements!.meta!.currentPage!;
            var nextNumber = number + 1;
            if (nextNumber <= store.announcements!.meta!.lastPage!) {
              return PaginationNumber(
                number: nextNumber,
                onTap: () {
                  print(nextNumber);
                  store.getAnnouncements(page: nextNumber.toString());
                },
                isSelected: false,
              );
            } else {
              return Container();
            }
          }),
          Observer(builder: (_) {
            var number = store.announcements!.meta!.currentPage!;
            var nextNumber = number + 2;
            if (nextNumber <= store.announcements!.meta!.lastPage!) {
              return PaginationNumber(
                number: nextNumber,
                onTap: () {
                  print(nextNumber);
                  store.getAnnouncements(page: nextNumber.toString());
                },
                isSelected: false,
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
      leftOnTap: () {
        print('left');
        store.doAnnouncementsPrevPage();
      },
      rightOnTap: () {
        print('right');
        store.doAnnouncementsNextPage();
      },
      numberOnTap: () {
        print('number');
      },
    );
  }
}

class GeneralPagination extends StatelessWidget {
  const GeneralPagination({
    Key? key,
    required this.store,
  }) : super(key: key);

  final NotificationListStore store;

  @override
  Widget build(BuildContext context) {
    return Pagination(
      hasNext: store.generalHasNext,
      hasPrev: store.generalHasPrev,
      pages: Row(
        children: [
          Observer(builder: (_) {
            var number = store.general!.meta!.currentPage!;
            var prevNumber = number - 2;
            if (prevNumber > 0) {
              return PaginationNumber(
                number: prevNumber,
                onTap: () {
                  print(prevNumber);
                  store.getGeneralNotifications(page: prevNumber.toString());
                },
                isSelected: false,
              );
            } else
              return Container();
          }),
          Observer(builder: (_) {
            var number = store.general!.meta!.currentPage!;
            var prevNumber = number - 1;
            if (prevNumber > 0) {
              return PaginationNumber(
                number: prevNumber,
                onTap: () {
                  print(prevNumber);
                  store.getGeneralNotifications(page: prevNumber.toString());
                },
                isSelected: false,
              );
            } else {
              return Container();
            }
          }),
          Observer(builder: (_) {
            return PaginationNumber(
              number: store.general!.meta!.currentPage,
              onTap: () {
                print(store.general!.meta!.currentPage);
              },
              isSelected: true,
            );
          }),
          Observer(builder: (_) {
            var number = store.general!.meta!.currentPage!;
            var nextNumber = number + 1;
            if (nextNumber <= store.general!.meta!.lastPage!) {
              return PaginationNumber(
                number: nextNumber,
                onTap: () {
                  print(nextNumber);
                  store.getGeneralNotifications(page: nextNumber.toString());
                },
                isSelected: false,
              );
            } else {
              return Container();
            }
          }),
          Observer(builder: (_) {
            var number = store.general!.meta!.currentPage!;
            var nextNumber = number + 2;
            if (nextNumber <= store.general!.meta!.lastPage!) {
              return PaginationNumber(
                number: nextNumber,
                onTap: () {
                  print(nextNumber);
                  store.getGeneralNotifications(page: nextNumber.toString());
                },
                isSelected: false,
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
      leftOnTap: () {
        print('left');
        store.doGeneralPrevPage();
      },
      rightOnTap: () {
        print('right');
        store.doGeneralNextPage();
      },
      numberOnTap: () {
        print('number');
      },
    );
  }
}
