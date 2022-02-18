import 'package:event/screens/home_page.dart';
import 'package:event/screens/login_page.dart';
import 'package:event/screens/new_activity.dart';
import 'package:event/screens/new_visitor.dart';
import 'package:event/screens/notification_detail.dart';
import 'package:event/screens/notifications_page.dart';
import 'package:event/screens/prize_list.dart';
import 'package:event/screens/scan_page.dart';
import 'package:event/screens/settings.dart';
import 'package:event/screens/start_up.dart';
import 'package:event/screens/visitor_detail.dart';
import 'package:event/screens/visitor_list.dart';
import 'package:event/widgets/select_screen.dart';
import 'package:event/model/arguments_visitor.dart';
import 'package:event/model/ArgumentNewActivity.dart';
import 'package:flutter/material.dart';

import 'package:event/services/consts.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  //RouteSettings di MaterialPageRoute hanya untuk keperluan analytics
  switch (settings.name) {
    case startupPageRoute:
      return MaterialPageRoute(
          builder: (context) => StartupPage(),
          settings: RouteSettings(name: startupPageRoute));
    case loginPageRoute:
      return MaterialPageRoute(
          builder: (context) => LoginPage(),
          settings: RouteSettings(name: startupPageRoute));
    case homePageRoute:
      return MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(name: startupPageRoute));
    case visitorPageRoute:
      return MaterialPageRoute(
          builder: (context) =>
              VisitorList(arguments: settings.arguments as ArgumentVisitor?),
          settings: RouteSettings(name: visitorPageRoute));
    case visitorDetailPage:
      print('Routes:' + settings.arguments.toString());
      return MaterialPageRoute(
          builder: (context) => VisitorDetail(arguments: settings.arguments),
          settings: RouteSettings(name: visitorDetailPage));
    case visitorNewPage:
      return MaterialPageRoute(
          builder: (context) => NewVisitorPage(),
          settings: RouteSettings(name: visitorNewPage));

    case newActivityPage:
      print('Routes:' + settings.arguments.toString());
      return MaterialPageRoute(
          builder: (context) =>
              NewActivity(arguments: settings.arguments as ArgumentNewActivity),
          settings: RouteSettings(name: newActivityPage));

    case settingsPage:
      return MaterialPageRoute(
          builder: (context) => SettingsPage(),
          settings: RouteSettings(name: settingsPage));
    case scanPageRoute:
      return MaterialPageRoute(
          builder: (context) => ScanPage(),
          settings: RouteSettings(name: scanPageRoute));
    case selectScreenRoute:
      return MaterialPageRoute(
          builder: (context) =>
              SelectScreen(arguments: settings.arguments as List<KeyMap>?),
          settings: RouteSettings(name: selectScreenRoute));
    case prizePageRoute:
      return MaterialPageRoute(
          builder: (context) => PrizeList(),
          settings: RouteSettings(name: prizePageRoute));
    case notificationsPageRoute:
      return MaterialPageRoute(builder: (context) => Notifications());
    case notificationDetailPage:
      return MaterialPageRoute(builder: (context) => NotificationDetail());
    default:
      return MaterialPageRoute(
          builder: (context) => StartupPage(),
          settings: RouteSettings(name: startupPageRoute));
  }
}
