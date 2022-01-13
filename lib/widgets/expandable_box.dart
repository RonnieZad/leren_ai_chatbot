//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableBox extends StatefulWidget {
  final String description, title;

  const ExpandableBox(
      {Key? key, required this.title, required this.description})
      : super(key: key);
  @override
  _ExpandableBoxState createState() => _ExpandableBoxState();
}

class _ExpandableBoxState extends State<ExpandableBox> {
  int height = 0;
  String firstHalf = '';
  String secondHalf = '';

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.description.length > 6) {
      firstHalf = widget.description.substring(0, 0);
      secondHalf = widget.description.substring(0, widget.description.length);
    } else {
      firstHalf = widget.description;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () async {
          HapticFeedback.selectionClick();
          setState(() {
            flag = !flag;
          });
        },
        child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: const Color.fromRGBO(240, 239, 197, 1)),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        flag
                            ? 'assets/images/fi-rr-angle-small-down.svg'
                            : 'assets/images/fi-rr-angle-small-up.svg',
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: flag
                      ? Container()
                      : Text(
                          (secondHalf),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.normal),
                        ),
                )
              ]),
            )),
      ),
    );
  }
}
