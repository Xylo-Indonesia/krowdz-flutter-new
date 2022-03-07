import 'dart:async';

import 'package:event/model/client.dart';
import 'package:event/services/analytics_services.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/language.dart';
import 'package:event/services/locator.dart';
import 'package:event/services/utilities.dart';
import 'package:event/widgets/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:event/services/routes.dart' as routes;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/user.dart';
import 'firebase_options.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyB1RqLxx7SBtv33RPY_8afpw0NYpGLVbx0',
      appId: '1:972252203421:web:38baf41f23e5514ac18774',
      messagingSenderId: '972252203421',
      projectId: 'krowdz-c5489',
    ),
  );

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // TODO: iOS push notifications

  //Crashlytics.instance.enableInDevMode = true;
  //FlutterError.onError = Crashlytics.instance.recordFlutterError;

  //print("Hive"+box.length.toString());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(ClientAdapter());
  await Hive.openBox<Client>('client');

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(PermissionsAdapter());
  Hive.registerAdapter(PivotAdapter());

  await Hive.openBox<User>('user');

  runZoned(() async {
    setupLocator();

    await locator<AppLanguage>().fetchLocale();

    runApp(Xylo(appLanguage: locator<AppLanguage>(), prefs: prefs));
  });
}

class Xylo extends StatefulWidget {
  final AppLanguage? appLanguage;
  final SharedPreferences? prefs;
  const Xylo({Key? key, this.appLanguage, this.prefs}) : super(key: key);

  @override
  State<Xylo> createState() => _XyloState();
}

class _XyloState extends State<Xylo> {
  String? _token;
  late Stream<String> _tokenStream;

  void setToken(String? token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BD4fsz919LRGDrLt4oXKEYTX8062IRxDVVPnol7eIyrM8qyJ5OhlRTHN5jV19s7dTD_MT61ZNBcNqB7b-xzXVgw')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Xylo',
      theme: ThemeData(
          primarySwatch: createMaterialColor(darkerBackground),
          fontFamily: 'SourceSansPro',
          backgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            border:
                OutlineInputBorder(borderRadius: new BorderRadius.circular(16)),
            focusedBorder:
                OutlineInputBorder(borderRadius: new BorderRadius.circular(16)),
            enabledBorder:
                OutlineInputBorder(borderRadius: new BorderRadius.circular(16)),
            errorBorder:
                OutlineInputBorder(borderRadius: new BorderRadius.circular(16)),
            errorStyle: TextStyle(fontSize: 14),
          )),
      // navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
      onGenerateRoute: routes.generateRoute,
      initialRoute: widget.prefs!.getString(pref_access_token)?.isEmpty ?? true
          ? startupPageRoute
          : homePageRoute,
      locale: widget.appLanguage!.appLocal,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: (BuildContext context, Widget? child) {
        ScreenUtil.init(
            BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height),
            designSize: Size(412, 892),
            context: context);
        //  ScreenUtil.init(context,
        //     designSize: Size(412, 892), allowFontScaling: true);
        final MediaQueryData data = MediaQuery.of(context);
        print("Width:" + MediaQuery.of(context).size.width.toString());
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor:
                0.9, //data.textScaleFactor > 2.0 ? 2.0 : data.textScaleFactor),
          ),
          child: child!,
        );
      },
    );
  }
}
