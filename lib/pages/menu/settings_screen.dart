//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:ui';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leren_ai_bot_app/constants/strings.dart';
import 'package:leren_ai_bot_app/widgets/bot_button.dart';
import 'package:leren_ai_bot_app/widgets/box_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ScrollController controller = ScrollController();
  TextEditingController webhookController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var prefs = Provider.of<SharedPreferences?>(context);
    var webhook = prefs?.getString('webhook') ?? '';
    var myName = prefs?.getString('myName') ?? '';
    var myEmail = prefs?.getString('myEmail') ?? '';
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
                        'Settings',
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
                          'assets/images/settings.png',
                        )),
                    SizedBox(
                      width: 14.w,
                    ),
                    Text(
                      'Configure\naccount and Leren🤖',
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
              padding: EdgeInsets.only(top: 20.h),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                BoxContainer(
                  title: 'Account Settings',
                  onPressed: () {
                    editAccount(prefs!);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text('Name'),
                          const Spacer(),
                          Text(myName)
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Email address'),
                          const Spacer(),
                          Text(myEmail)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BoxContainer(
                  title: 'App Details',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Text('App Name'),
                          Spacer(),
                          Text('Leren')
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: const <Widget>[
                          Text('App Version'),
                          Spacer(),
                          Text('v1.0.1'),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          editWebhook(prefs!);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              const Text('Webhook'),
                              const Spacer(),
                              Text('https://$webhook'),
                              SvgPicture.asset(
                                  'assets/images/fi-rr-angle-small-right.svg',
                                  width: 16.0,
                                  height: 16.0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BoxContainer(
                  title: 'Share Leren',
                  child: BouncingWidget(
                    onPressed: () {
                      _onShare(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            const Text(
                                'Share Leren with your friends, Sharing is loving😛🥰'),
                            const Spacer(),
                            SvgPicture.asset('assets/images/fi-rr-share.svg',
                                width: 16.0, height: 16.0)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BoxContainer(
                  title: 'Appearance',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          const Text('Light Mode'),
                          const Spacer(),
                          CupertinoSwitch(
                              trackColor:
                                  const Color.fromRGBO(251, 241, 212, 1),
                              activeColor: Colors.amber,
                              value: true,
                              onChanged: (val) {}),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          loadBackgrounds(prefs!);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              const Text('Chat Background'),
                              const Spacer(),
                              SvgPicture.asset(
                                  'assets/images/fi-rr-angle-small-right.svg',
                                  width: 16.0,
                                  height: 16.0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share(
        'Hi I am using this app called Leren, it is an AI Bot that helps me with everything at campus, like finding reading materials, directions, awareness, finding hostels and restaurants and a friend I can always talk to.',
        subject: 'Leren AI Bot',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void loadBackgrounds(SharedPreferences prefs) {
    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Choose Chat Background',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: .65),
                    itemCount: backgrounds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          prefs.setString('setBg',
                              'assets/images/${backgrounds[index]['image']!}');
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 220.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/${backgrounds[index]['image']!}'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(height: 10.h),
                            Text(backgrounds[index]['name']!)
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ));
        });
  }

  void editWebhook(SharedPreferences prefs) {
    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close,
                                size: 24.w, color: Colors.red)),
                      ),
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        const Text(
                          'Change Webhook',
                          textScaleFactor: 0.7,
                        ),
                        SizedBox(height: 20.h),
                        Text('Enter Url to route and link app to bot server',
                            textScaleFactor: 0.7,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.sp, fontFamily: 'Poppins')),
                        SizedBox(height: 75.h),
                        Padding(
                          padding: EdgeInsets.all(18.w),
                          child: Container(
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf5f5f5),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: TextFormField(
                                controller: webhookController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter url here...',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                )),
                          ),
                        ),
                        SizedBox(height: 65.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 60.h,
                                  child: CupertinoButton(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(18.r),
                                      child: Text('Apply Changes',
                                          textScaleFactor: 0.7,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w900)),
                                      onPressed: () {
                                        Navigator.pop(context);

                                        if (webhookController.text
                                            .trim()
                                            .isNotEmpty) {
                                          prefs.setString('webhook',
                                              webhookController.text.trim());
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ]),
                    ],
                  )));
        });
  }

  void editAccount(SharedPreferences prefs) {
    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close,
                                size: 24.w, color: Colors.red)),
                      ),
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        const Text(
                          'Edit Account',
                          textScaleFactor: 0.7,
                        ),
                        SizedBox(height: 10.h),
                        Text('Make changes to your account',
                            textScaleFactor: 0.7,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.sp, fontFamily: 'Poppins')),
                        SizedBox(height: 35.h),
                        Padding(
                          padding: EdgeInsets.all(18.w),
                          child: Container(
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf5f5f5),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter name here...',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(18.w),
                          child: Container(
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf5f5f5),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter email here...',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                )),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 60.h,
                                  child: CupertinoButton(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(18.r),
                                      child: Text('Apply Changes',
                                          textScaleFactor: 0.7,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w900)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        if (nameController.text
                                            .trim()
                                            .isNotEmpty) {
                                          prefs.setString('myName',
                                              nameController.text.trim());
                                        }
                                        if (emailController.text
                                            .trim()
                                            .isNotEmpty) {
                                          prefs.setString('myEmail',
                                              emailController.text.trim());
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ]),
                    ],
                  )));
        });
  }
}
