import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class BorderIcon extends StatelessWidget {
  final String image;
  const BorderIcon({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40.h,
          padding: EdgeInsets.all(13.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: kDefaultBoxShadow,
              color: Theme.of(context).inputDecorationTheme.fillColor,
              shape: BoxShape.rectangle),
          child: SvgPicture.asset(
            "assets/svgs/$image",
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
