//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/app_drawer.dart';

void main() {
  if (Platform.isIOS) {
//do nothing, there properties have been configured in the ios project
  } else {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SystemChrome.setApplicationSwitcherDescription(
    //     const ApplicationSwitcherDescription(label: 'Leren'));
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
