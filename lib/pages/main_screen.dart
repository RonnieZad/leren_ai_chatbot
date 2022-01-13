//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leren_ai_bot_app/widgets/bot_button.dart';

import 'chat_screen.dart';
import 'faq_screen.dart';
import 'talk_to_us.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.isOpen, required this.innerDrawerKey})
      : super(key: key);
  final GlobalKey<InnerDrawerState> innerDrawerKey;
  bool isOpen;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            height: 460.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(151, 122, 104, 1),
              Color.fromRGBO(90, 70, 66, 1),
            ])),
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Stack(
                children: [
                  Stack(
                    children: <Widget>[
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black, Colors.transparent])
                              .createShader(
                            Rect.fromLTRB(
                              0,
                              4.h,
                              rect.width,
                              200,
                            ),
                          );
                        },
                        blendMode: BlendMode.dstATop,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/leren.webp',
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-.9, -0.95),
                        child: BouncingWidget(
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            widget.innerDrawerKey.currentState!.toggle();

                            setState(() {
                              widget.isOpen = !widget.isOpen;
                            });
                          },
                          child: Material(
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                width: 45.w,
                                height: 45.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: const Color.fromRGBO(
                                        151, 122, 104, 0.5)),
                                child: (widget.innerDrawerKey.currentState
                                            ?.isOpen() ||
                                        widget.isOpen)
                                    ? Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: SvgPicture.asset(
                                          'assets/images/align-left.svg',
                                        ),
                                      )
                                    : Icon(
                                        Icons.close,
                                        size: 26.w,
                                        color:
                                            const Color.fromRGBO(90, 70, 66, 1),
                                      ),
                              )),
                        ),
                      ),
                      Align(
                          alignment: const Alignment(0.0, -0.95),
                          child: Text(
                            'Need help?',
                            style: TextStyle(fontSize: 24.sp),
                          )),
                      Align(
                          alignment: const Alignment(0.0, -0.85),
                          child: Text(
                            'I\'m Leren',
                            style: TextStyle(
                                color: const Color.fromRGBO(58, 29, 30, 1),
                                fontSize: 46.sp,
                                fontWeight: FontWeight.w800),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 460.h),
            child: CupertinoScrollbar(
              controller: controller,
              isAlwaysShown: true,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 20.h),
                controller: controller,
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText('Need any help?'),
                          TypewriterAnimatedText(
                              'Are you looking for something?'),
                          TypewriterAnimatedText('Want to find out something?'),
                          TypewriterAnimatedText(
                              'Need someone to share or talk with?'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      'I am your personal assistant, here to help you with\nanything you need at campus😛',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const BotButton(
                      title: 'Chat',
                      description: 'Start a conversation now!',
                      iconImage: 'assets/images/chat.png',
                      paint: Color.fromRGBO(255, 199, 201, 1),
                      page: ChatPage()),
                  SizedBox(height: 15.h),
                  const BotButton(
                      title: 'FAQs',
                      description: 'Find intelligent answers instantly',
                      iconImage: 'assets/images/question.png',
                      paint: Color.fromRGBO(255, 244, 214, 1),
                      page: FAQ()),
                  SizedBox(height: 15.h),
                  const BotButton(
                      title: 'Talk to us',
                      description: 'Get help beamed to your inbox',
                      iconImage: 'assets/images/paper-plane.png',
                      paint: Color.fromRGBO(188, 197, 250, 1),
                      page: TalkToUs()),
                  SizedBox(height: 35.h),
                  const Text('Version: 1.0.1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  const Divider(
                    endIndent: 100.0,
                    indent: 100.0,
                    color: Color.fromRGBO(58, 29, 30, 1),
                  ),
                  const Text(
                    'CS-14',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 45.h),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
