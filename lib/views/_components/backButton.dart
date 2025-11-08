import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.r),
      decoration: BoxDecoration(
          boxShadow: kDefaultBoxShadow,
          color: Theme.of(context).inputDecorationTheme.fillColor,
          shape: BoxShape.circle),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).appBarTheme.iconTheme!.color,
        ),
      ),
    );
  }
}
