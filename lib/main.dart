import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:leren_ai_bot_app/pages/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  if (Platform.isIOS) {
//do nothing, there properties have been configured in the ios project
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setApplicationSwitcherDescription(
        const ApplicationSwitcherDescription(label: 'Leren'));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<SharedPreferences?>.value(
            value: SharedPreferences.getInstance().asStream(),
            initialData: null,
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(520, 890),
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Leren',
            color: const Color(0xFFf5f6fb),
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.7),
                child: widget!,
              );
            },
            home: const AppDrawer(),
          ),
        ));
  }
}
