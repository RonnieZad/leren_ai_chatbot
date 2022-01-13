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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leren_ai_bot_app/widgets/bot_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TalkToUs extends StatefulWidget {
  const TalkToUs({Key? key}) : super(key: key);

  @override
  _TalkToUsState createState() => _TalkToUsState();
}

class _TalkToUsState extends State<TalkToUs> {
  @override
  Widget build(BuildContext context) {
    
    var prefs = Provider.of<SharedPreferences?>(context);
    var myEmail = prefs?.getString('myEmail') ?? '';

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 240.h,
          color: const Color.fromRGBO(188, 197, 250, 1),
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
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 26.sp),
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
                          'assets/images/message.png',
                        )),
                    SizedBox(
                      width: 14.w,
                    ),
                    Text(
                      'Get answers sent to\nyour inbox👍🏼',
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
          padding: EdgeInsets.only(top: 240.h, right: 20.w, left: 20.0),
          child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color.fromRGBO(34, 11, 40, .1),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      SvgPicture.asset(
                        'assets/images/fi-rr-envelope.svg',
                        height: 16.0,
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text('FROM: $myEmail'),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                const Text('Message Body'),
                SizedBox(height: 13.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color.fromRGBO(34, 11, 40, .1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextFormField(
                      maxLines: 20,
                      decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: SvgPicture.asset(
                              'assets/images/fi-rr-comment-alt.svg',
                              height: 16.0,
                              width: 16.0,
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const Text('We reply as soon as possible!'),
              ]),
        ),
        Positioned(
            bottom: 30.h,
            right: 30.w,
            left: 30.w,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                height: 60.h,
                child: CupertinoButton(
                  color: const Color.fromRGBO(34, 11, 40, 1),
                  borderRadius: BorderRadius.circular(16.r),
                  child: Text(
                    'Send',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp),
                  ),
                  onPressed: () {},
                ),
              ),
            ))
      ],
    ));
  }
}
