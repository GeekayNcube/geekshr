import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class DashboardIcon extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback? onIconTap;
  const DashboardIcon(
      {super.key,
      required this.image,
      required this.text,
      required this.onIconTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onIconTap,
      child: Column(
        children: [
          Container(
            width: 60.h,
            padding: EdgeInsets.all(13.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: kDefaultBoxShadow,
                color: Theme.of(context).inputDecorationTheme.fillColor,
                shape: BoxShape.rectangle),
            child: SvgPicture.asset(
              "assets/svgs/$image",
              width: 30.h,
              height: 30.h,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
