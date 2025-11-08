import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    String title = data[0];
    String desc = data[1];
    String startDate = data[2];

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          RPadding(
            padding: REdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(title: 'Announcements'),
                SizedBox(height: 36.h),
                Text(startDate, style: Theme.of(context).textTheme.bodyMedium),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 20.h),
                Text(desc, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
