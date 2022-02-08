import 'package:event/services/analytics_services.dart';
import 'package:get_it/get_it.dart';

import 'language.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => AppLanguage());
}