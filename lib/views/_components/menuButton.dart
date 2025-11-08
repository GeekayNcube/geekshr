import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class MenuButton extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap;

  const MenuButton(
      {super.key, required this.image, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
          boxShadow: kDefaultBoxShadow,
          color: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: ListTile(
        onTap: onTap,
        contentPadding: REdgeInsets.all(0),
        leading: Theme.of(context).brightness == Brightness.light
            ? SvgPicture.asset(
                'assets/svgs/$image',
                color: Colors.grey,
              )
            : SvgPicture.asset(
                'assets/svgs/$image',
                color: Colors.white,
              ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
