import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:padi/core/utils/app_notifications.dart';
import 'package:padi/core/utils/work_manager_utils.dart';
import 'modules/app.dart';

Future main() async {

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
      )
  );

  await AppNotifications.initNotification();
  await AppNotifications.requestPermissions();
  initializeWorkManager();

  initializeDateFormatting().then((_) => runApp(
    const ProviderScope(
      child: Padi()
    ))
  );

}