import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leren_ai_bot_app/widgets/bot_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
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
                        'About Leren',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 28.sp),
                      ),
                      const Spacer(),
                      Container(
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
                          'assets/images/idea.png',
                        )),
                    SizedBox(
                      width: 14.w,
                    ),
                    Text(
                      'Get to know Leren\nabout your assitant💡',
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
          padding: EdgeInsets.only(top: 240.h, left: 20.w),
          child: CupertinoScrollbar(
            controller: controller,
            isAlwaysShown: true,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding:  EdgeInsets.only(right: 20.w, top: 20.h, bottom: 40.h),
              controller: controller,
              shrinkWrap: true,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: 'LEREN,',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(children: [
                        TextSpan(
                            text:
                                ' is an intellignet chatbot powered by AI. You can ask her about colleges🕍, hostels🏢, restaurants🍟, halls of resiendence🏠, finding you course material📚, directions📍, weather🌤, counseling, date and time📅 and anything else about Muk Campus. Text her right away. If you need any help, ask Leren')
                      ])
                    ])),
                SizedBox(height: 30.h),
                Text('Topics',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 25.sp)),
                Divider(
                  color: Colors.black,
                  endIndent: 320.w,
                ),
                RichText(
                    text: TextSpan(
                        text:
                            'Leren is still young, about 3 years old and her mind and intelligence is still evolving. Here are some quick topics that you can discuss with her. If you notice any hiccups or prefer a topic or feature kindly write to us in email and we will be glad to better Leren with your assistance✌🏽\n\n',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(children: [
                        TextSpan(
                            text:
                                '* General knowledge about MUK Campus\n* Hostels and Halls residence\n* Lifestyle\n* Entertainment\n* Chitchat Conversations\n* Health care, counselling and first aid\n* Career guidance')
                      ])
                    ])),
                SizedBox(height: 30.h),
                Text('Developers',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 25.sp)),
                Divider(
                  color: Colors.black,
                  endIndent: 320.w,
                ),
                RichText(
                    text: TextSpan(
                        text:
                            'Leren is proudly developed with love❤️ by a team of Makerere Students of the Computer Science class. They are shortlisted below\n\n',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(children: [
                        TextSpan(
                            text:
                                '1. Ronald Zad Muhanguzi\n2. Julius Nasasira\n3. Dianah Wisdom Nakakande\n4. Joan Deborah Nalikka')
                      ])
                    ]))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
