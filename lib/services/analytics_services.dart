import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService{
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  FirebaseAnalytics getAnalytics(){
    return analytics;
  }

  FirebaseAnalyticsObserver getAnalyticsObserver(){
    return FirebaseAnalyticsObserver(analytics: analytics);
  }
}