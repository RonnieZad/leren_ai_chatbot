//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leren_ai_bot_app/pages/main_screen.dart';
import 'package:leren_ai_bot_app/pages/menu/info_screen.dart';
import 'package:leren_ai_bot_app/pages/menu/settings_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      tapScaffoldEnabled: true,
      swipe: false,
      borderRadius: 30,
      backgroundDecoration: const BoxDecoration(
        color: Color.fromRGBO(215, 158, 138, 1),
      ),
      colorTransitionChild: const Color.fromRGBO(90, 70, 66, 1),
      leftAnimationType: InnerDrawerAnimation.quadratic,
      leftChild: Material(
          child: Container(
              color: const Color.fromRGBO(215, 158, 138, 1),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(58, 29, 30, 1),
                      ),
                    ),
                    const Spacer(),
                    menuButton(
                      title: 'Home',
                      iconData: 'assets/images/fi-rr-home.svg',
                      innerDrawerKey: _innerDrawerKey,
                    ),
                    menuButton(
                      title: 'About',
                      iconData: 'assets/images/fi-rr-info.svg',
                      page: const Info(),
                    ),
                    menuButton(
                      title: 'Settings',
                      iconData: 'assets/images/fi-rr-settings.svg',
                      page: const Settings(),
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Text(
                      "Leren\nYour everyday friend☺️",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(58, 29, 30, 1),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    )
                  ],
                ),
              ))),
      scaffold: MainScreen(
        isOpen: isOpen,
        innerDrawerKey: _innerDrawerKey,
      ),
    );
  }

  Padding menuButton(
      {Widget? page,
      GlobalKey<InnerDrawerState>? innerDrawerKey,
      required String iconData,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: TextButton(
        onPressed: () {
          HapticFeedback.selectionClick();
          if (page == null) {
            innerDrawerKey!.currentState!.toggle();
            setState(() {
              isOpen = !isOpen;
            });
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Row(
          children: [
            SvgPicture.asset(
              iconData,
              color: const Color.fromRGBO(58, 29, 30, 1),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(58, 29, 30, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}