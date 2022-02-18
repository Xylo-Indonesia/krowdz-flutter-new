import 'dart:async';

import 'package:event/model/client.dart';
import 'package:event/services/analytics_services.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/language.dart';
import 'package:event/services/locator.dart';
import 'package:event/services/utilities.dart';
import 'package:event/widgets/styles.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class Xylo extends StatelessWidget {
  final AppLanguage? appLanguage;
  final SharedPreferences? prefs;
  const Xylo({Key? key, this.appLanguage, this.prefs}) : super(key: key);

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
      initialRoute: prefs!.getString(pref_access_token)?.isEmpty ?? true
          ? startupPageRoute
          : homePageRoute,
      locale: appLanguage!.appLocal,
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
