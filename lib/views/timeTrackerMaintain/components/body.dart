import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geekshr/controllers/timeTrackerController.dart';
import 'package:geekshr/views/_components/header.dart';

import '../../_components/c_dropdown_b.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    TimeTrackerController timeTrackerController = TimeTrackerController();

    return FutureBuilder(
      future: timeTrackerController.getSiteNear(), // async work

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            );
          default:
            return Scaffold(
              body: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  RPadding(
                    padding: REdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        const Header(title: 'Tracker Maintain'),
                        SizedBox(height: 36.h),
                        CDropdownButtonFormField(
                          hintText: "Location",
                          items: timeTrackerController.sitesDropDownlist,
                          prefixIcon: const Icon(Icons.location_city),
                          onChanged: (data) {
                            timeTrackerController.siteId = data.obs;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
