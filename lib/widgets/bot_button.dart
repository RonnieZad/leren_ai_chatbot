//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BotButton extends StatelessWidget {
  final String title, description, iconImage;
  final Color paint;
  final Widget page;
  const BotButton({
    required this.title,
    required this.description,
    required this.iconImage,
    required this.page,
    required this.paint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        HapticFeedback.selectionClick();
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 30.w, left: 30.w),
        child: Material(
          borderRadius: BorderRadius.circular(12.r),
          shadowColor: const Color.fromRGBO(151, 122, 104, 0.3),
          elevation: 8.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                        color: paint, borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SizedBox(
                          width: 36.w,
                          height: 36.w,
                          child: Image.asset(iconImage)),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: const Color.fromRGBO(80, 36, 27, 1),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(description)
                    ],
                  ),const Spacer(),
                   BouncingWidget(
        onPressed: () {
          HapticFeedback.selectionClick();
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
                    child: Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: paint, 
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      
                      child: Icon(CupertinoIcons.arrow_turn_up_right, size: 20.w,)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class BotBackButton extends StatelessWidget {
  const BotBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: SvgPicture.asset('assets/images/fi-rr-arrow-small-left.svg'),
            ),
          )),
    );
  }
}
