// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1RqLxx7SBtv33RPY_8afpw0NYpGLVbx0',
    appId: '1:972252203421:web:38baf41f23e5514ac18774',
    messagingSenderId: '972252203421',
    projectId: 'krowdz-c5489',
    authDomain: 'krowdz-c5489.firebaseapp.com',
    databaseURL: 'https://krowdz-c5489-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'krowdz-c5489.appspot.com',
    measurementId: 'G-WH1VDV5LMM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCREUpIeKMD_0qSKGxoQbL19zv3wPh_ltA',
    appId: '1:972252203421:android:bdbb199e4526a38dc18774',
    messagingSenderId: '972252203421',
    projectId: 'krowdz-c5489',
    databaseURL: 'https://krowdz-c5489-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'krowdz-c5489.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkajW1An1ls9it6aySDjUkI_HJBW17AZs',
    appId: '1:972252203421:ios:3a2b5f21074cf28cc18774',
    messagingSenderId: '972252203421',
    projectId: 'krowdz-c5489',
    databaseURL: 'https://krowdz-c5489-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'krowdz-c5489.appspot.com',
    iosClientId: '972252203421-97cdspg3p14n5dbkbarbh0bqv1jeiebm.apps.googleusercontent.com',
    iosBundleId: 'com.krowdz.app',
  );
}