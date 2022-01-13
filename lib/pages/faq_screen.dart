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
import 'package:leren_ai_bot_app/widgets/bot_button.dart';
import 'package:leren_ai_bot_app/widgets/expandable_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 240.h,
          color: const Color.fromRGBO(251, 241, 212, 1),
          child: Stack(
            children: <Widget>[
              Positioned(
                  left: 25.w,
                  right: 25.w,
                  top: 60.h,
                  child: Row(
                    children: <Widget>[
                      const BotBackButton(),
                      const Spacer(),
                      Text(
                        'FAQ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 28.sp),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 45.w,
                        height: 45.w,
                      ),
                    ],
                  )),
              Positioned(
                bottom: 0.0,
                left: 40.w,
                right: 40.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 175.w,
                        height: 175.w,
                        child: Image.asset(
                          'assets/images/question-2.png',
                        )),
                    SizedBox(
                      width: 14.w,
                    ),
                    Text(
                      'Questions? We\'ve got\ninstant answers⚡️',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 240.h),
          child: CupertinoScrollbar(
            controller: controller,
            isAlwaysShown: true,
            child: ListView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 20.h),
              shrinkWrap: true,
              children: const <Widget>[
                ExpandableBox(
                    title: 'Who is Leren?',
                    description:
                        'Leren is a selfcare Artificial Intelligence bot that is here to help you with anything around campus. Leren is your new buddy to help you show you the ropes if you are fresher or even a continuing student.'),
                ExpandableBox(
                    title: 'How can I chat or talk with Leren?',
                    description:
                        'You can talk with Leren via chat, tap the chat button on the main screen to start texting Leren. You can send messages back and forth just like you\'d with a friend on Whatsapp.\nFuture works are coming to make Leren available via voice message.'),
                ExpandableBox(
                    title:
                        'Do I need an internet conncetion to chat with Leren?',
                    description:
                        'The short answer is YES! You need a stable internet connection to chat with Leren. However future works will make Leren available to toye device even without an active internet conncetion.\nStay tuned for more updates😉'),
                        
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
