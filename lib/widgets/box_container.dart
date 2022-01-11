//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer(
      {Key? key, this.title,  this.onPressed, this.hasPadding = true, required this.child})
      : super(key: key);
  final String? title;
  final Widget child;
  final bool hasPadding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35.w, right: 35.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Row(
                  children: [
                    Text(title!,
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w800)),
                    Spacer(),
                  onPressed == null? Container():  BouncingWidget(
                        onPressed: onPressed ?? (){},
                        child: SvgPicture.asset('assets/images/fi-rr-edit.svg',
                            width: 16.0, height: 16.0)),
                  ],
                )
              : Container(),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 8),
                ),
              ],
              borderRadius: BorderRadius.circular(
                17.r,
              ),
            ),
            child: hasPadding
                ? Padding(
                    padding: EdgeInsets.all(
                      22.w,
                    ),
                    child: child)
                : child,
          ),
        ],
      ),
    );
  }
}
