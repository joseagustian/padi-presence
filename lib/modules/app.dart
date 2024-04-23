import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import '../core/constants/strings.dart';
import '../core/routes/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Padi extends ConsumerStatefulWidget {
  const Padi({super.key});

  @override
  ConsumerState<Padi> createState() => _PadiState();
}

class _PadiState extends ConsumerState<Padi> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.noScaling,
      ),
      child: MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('id'),
        ],
        locale: const Locale('id'),
        routerConfig: router,
        title: Strings.appName,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueGrey
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: child,
          );
        },
      ),
    );
  }
}