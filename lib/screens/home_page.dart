import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:event/model/arguments_visitor.dart';
import 'package:event/services/consts.dart';
import 'package:event/stores/dashboard_store.dart';
import 'package:event/widgets/admin_calendar.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/card_activity.dart';
import 'package:event/widgets/card_prize.dart';
import 'package:event/widgets/card_visitors.dart';
import 'package:event/widgets/circle_button.dart';
import 'package:event/widgets/nav_button.dart';
import 'package:event/widgets/profile.dart';
import 'package:event/widgets/styles.dart';
import 'package:event/widgets/total_visitors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  final DashboardStore store = DashboardStore();

  HomePage() {
    store.getDashboardSummary();
    store.getDashboardActivity();
    store.getDashboardPrize();
    store.getClient();
    store.getUser();
    store.getDate();
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print("Scale Factor: " + MediaQuery.of(context).textScaleFactor.toString());

    return BlackTheme(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Observer(builder: (_) {
                        return Profile(
                            client: widget.store.isClientReady
                                ? widget.store.client.name
                                : '',
                            name: widget.store.isUserReady
                                ? widget.store.user.data.name
                                : '',
                            isLoading: !widget.store.isClientReady,
                            image: widget.store.isClientReady
                                ? widget.store.client.logo
                                : '');
                      }),
                      Badge(
                          showBadge: true,
                          padding: EdgeInsets.all(3),
                          position: BadgePosition(top: -2, end: -4),
                          badgeColor: redColor,
                          badgeContent: Text(
                            '50',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          child: CircleButton(
                            child: Image(
                              image: AssetImage('assets/images/bell.png'),
                            ),
                            onTap: () {
                              print("notifications");
                              Navigator.of(context)
                                  .pushNamed(notificationsPageRoute);
                            },
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(width: double.infinity),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Column(
                                children: [
                                  Observer(builder: (_) {
                                    if (widget.store.isClientReady &&
                                        "admin" ==
                                            widget.store.user.data.role) {
                                      return AdminCalendar(
                                        date: widget.store.selected_date,
                                        onTap: () async {
                                          final DateTime picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: currentDate,
                                            firstDate: currentDate.subtract(
                                                const Duration(days: 360)),
                                            lastDate: currentDate
                                                .add(const Duration(days: 360)),
                                          );

                                          if (picked == null ||
                                              picked == DateTime.now()) {
                                            print('cancelled');
                                          } else {
                                            print('confirm $picked');
                                            currentDate = picked;
                                            widget.store.setDate(picked);
                                          }
                                        },
                                      );
                                    }
                                    return Container();
                                  }),
                                  Center(
                                    child: Observer(
                                      builder: (_) => TotalVisitors(
                                        visitor1: widget.store.visitor1,
                                        visitor2: widget.store.visitor2,
                                        date: widget.store.selected_date,
                                        isLoading: !widget
                                            .store.isDashboardSummaryReady,
                                        isAdmin: "admin" ==
                                                widget.store.user.data.role
                                            ? true
                                            : false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Observer(
                                          builder: (_) => CardVisitors(
                                            title: "Online Visitors",
                                            visitor1: widget.store.visitor1,
                                            visitor2: widget.store.visitor2,
                                            color: redColor,
                                            isLoading: !widget
                                                .store.isDashboardSummaryReady,
                                            onTap: () {
                                              print('online');
                                              Navigator.pushNamed(
                                                  context, visitorPageRoute,
                                                  arguments: ArgumentVisitor(
                                                      keyword_by: 'online',
                                                      keyword: ''));
                                            },
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        flex: 10,
                                        child: Observer(
                                          builder: (_) => CardVisitors(
                                            title: "Offline Visitors",
                                            visitor1: widget.store.visitor2,
                                            visitor2: widget.store.visitor1,
                                            color: primaryColor,
                                            isLoading: !widget
                                                .store.isDashboardSummaryReady,
                                            onTap: () {
                                              print('offline');
                                              Navigator.pushNamed(
                                                  context, visitorPageRoute,
                                                  arguments: ArgumentVisitor(
                                                      keyword_by: 'offline',
                                                      keyword: ''));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 6),
                                      child: Text(
                                        "Activity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  Observer(builder: (_) {
                                    if (null !=
                                            widget.store.dashboardActivity &&
                                        null !=
                                            widget.store.dashboardActivity.data
                                                .activity &&
                                        true ==
                                            widget.store.dashboardActivity
                                                .status) {
                                      print('cetak activity');
                                      Column col = Column(
                                        children: [],
                                      );

                                      for (var ac in widget.store
                                          .dashboardActivity.data.activity) {
                                        var ca = CardActivity(
                                          imageUrl: ac.icon,
                                          gamesMaxValue: ac.total,
                                          gamesValue:
                                              double.parse(ac.achievement)
                                                  .ceil(),
                                          onTap: () {
                                            print("" + ac.name);
                                            Navigator.pushNamed(
                                                context, visitorPageRoute,
                                                arguments: ArgumentVisitor(
                                                    keyword_by: 'activity_' +
                                                        ac.id.toString(),
                                                    keyword: ac.name));
                                          },
                                          gamesName: ac.name,
                                          isLoading: !widget
                                              .store.isDashboardActivityReady,
                                        );

                                        var index = widget.store
                                            .dashboardActivity.data.activity
                                            .indexOf(ac);
                                        if ("pic" ==
                                                widget.store.user.data.role &&
                                            ac.isPic == true)
                                          col.children.add(ca);
                                        if ("admin" ==
                                            widget.store.user.data.role)
                                          col.children.add(ca);
                                        // if ("pic" ==
                                        //         widget.store.user.data.role &&
                                        //     index == 0) col.children.add(ca);
                                        // if ("admin" ==
                                        //     widget.store.user.data.role)
                                        //   col.children.add(ca);
                                      }
                                      return col;
                                    }
                                    {
                                      return Column(
                                        children: [
                                          CardActivity(
                                            isLoading: true,
                                          ),
                                          CardActivity(
                                            isLoading: true,
                                          ),
                                          CardActivity(
                                            isLoading: true,
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 6),
                                      child: Text(
                                        "Prize List",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Observer(builder: (_) {
                                        if (null !=
                                                widget.store.dashboardPrize &&
                                            true ==
                                                widget.store.dashboardPrize
                                                    .status) {
                                          print('cetak prize');
                                          Row row = Row(
                                            children: [],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                          );
                                          Expanded ex = Expanded(
                                            child: row,
                                          );

                                          int i = 0;
                                          for (var pr in widget.store
                                              .dashboardPrize.data.prize) {
                                            if (i >= 3) break;
                                            var cardPrize = CardPrize(
                                              image: pr.image,
                                              onTap: () {
                                                print('prize ' + pr.name);
                                              },
                                              name: "" + pr.name,
                                              stock: pr.total,
                                            );

                                            var sb = SizedBox(
                                              width: 16,
                                            );
                                            //row.children.add(cardPrize);
                                            row.children.add(cardPrize);
                                            row.children.add(sb);
                                            i++;
                                          }

                                          var seeMore = Expanded(
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print('see all prizes');
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            prizePageRoute);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  16)),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                    width: double.infinity,
                                                    child: Stack(
                                                      children: [
                                                        AspectRatio(
                                                          aspectRatio: 1 / 1,
                                                          child: Container(),
                                                        ),
                                                        Positioned.fill(
                                                          child: Center(
                                                            child: Text(
                                                              "See All\nPrize",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12.sp,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp),
                                                )
                                              ],
                                            ),
                                          );
                                          row.children.add(seeMore);
                                          return ex;
                                        }
                                        {
                                          return Container();
                                        }
                                      }),
                                      // CardPrize(
                                      //   image: 'https://picsum.photos/300/300',
                                      //   onTap: (){
                                      //     print('prize');
                                      //   },
                                      //   name: "Galaxy Note 8",
                                      //   stock: 120,
                                      // ),
                                      // SizedBox(
                                      //   width: 16,
                                      // ),
                                      // CardPrize(
                                      //   image: 'https://picsum.photos/300/300',
                                      //   onTap: (){
                                      //     print('prize');
                                      //   },
                                      //   name: "Galaxy Note 8",
                                      //   stock: 120,
                                      // ),
                                      // SizedBox(
                                      //   width: 16,
                                      // ),
                                      // CardPrize(
                                      //   image: 'https://picsum.photos/300/300',
                                      //   onTap: (){
                                      //     print('prize');
                                      //   },
                                      //   name: "Galaxy Note 8",
                                      //   stock: 120,
                                      // ),
                                      // SizedBox(
                                      //   width: 16,
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 140,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Arc(
                              arcType: ArcType.CONVEX,
                              edge: Edge.TOP,
                              height: 85,
                              clipShadows: [ClipShadow(color: Colors.black)],
                              child: new Container(
                                height: 85,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        redColor,
                                        primaryColor,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.12,
                              top: 0,
                              child: NavButton(
                                title: "Visitor List",
                                image: 'assets/images/menu.png',
                                onTap: () {
                                  print('visitor');
                                  Navigator.pushNamed(
                                      context, visitorPageRoute);
                                },
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.33,
                              top: -20,
                              child: NavButton(
                                title: "Scan Code",
                                image: 'assets/images/qr.png',
                                onTap: () async {
                                  print('qr');
                                  Map<PermissionGroup, PermissionStatus>
                                      permissions = await PermissionHandler()
                                          .requestPermissions(
                                              [PermissionGroup.camera]);
                                  if (permissions[PermissionGroup.camera] ==
                                      PermissionStatus.granted) {
                                    Navigator.pushNamed(context, scanPageRoute);
                                  }
                                },
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.54,
                              top: -20,
                              child: NavButton(
                                title: "New\nRegister",
                                image: 'assets/images/add.png',
                                onTap: () {
                                  print('add');
                                  Navigator.pushNamed(context, visitorNewPage);
                                },
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.74,
                              top: 0,
                              child: NavButton(
                                title: "Settings",
                                image: 'assets/images/settings.png',
                                onTap: () {
                                  print('settings');
                                  Navigator.pushNamed(context, settingsPage);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
