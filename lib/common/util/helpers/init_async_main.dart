import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catcher/catcher.dart';

import '../../const/app_consts.dart';
import 'bloc_observer.dart';
import 'local_notifications.dart';
import 'notifications.dart';
import 'shared_preferences_helper.dart';

class Initialization {
  static initNotifications() async {
    await LocalNotificationService.initialize();
    await NotificationService().initialize();
    await NotificationService().getToken();
  }

  static Future<void> initMain(Widget main, {FirebaseOptions? options, Future<void> Function()? gitItConfig}) async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppBlocObserver();
    await EasyLocalization.ensureInitialized();
    if (gitItConfig != null) {
      await gitItConfig();
    }
    await SharedPreferencesHelper.saveData(key: AppKeys.langNo, value: 1);
    if (options != null) {
      await Firebase.initializeApp(
        options: options,
      );
      await initNotifications();
    }

    CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

    CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [ToastHandler()]);

    Catcher(rootWidget: initLocalization(main), debugConfig: debugOptions, releaseConfig: releaseOptions);
  }

  static initLocalization(Widget main) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: main,
    );
  }
}
