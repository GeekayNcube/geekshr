import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/dashboardController.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../util/preferences_manager.dart';
import '../../_components/borderIcon.dart';
import '../../_components/dasboardIcon.dart';
import '../../_components/notifications_badge.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.find<DashboardController>();
    var selectedPageIndex = 0.obs;
    var name = PreferencesManager.getInstance().getStringValue("firstName");

    return FutureBuilder(
      future: dashboardController.getData(), // async work

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
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    children: [
                      RPadding(
                        padding: REdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // width: 200.w,
                                  padding: REdgeInsets.all(14),

                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 130.h,
                                        child: Image.asset(
                                          'assets/images/logoname.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    boxShadow: kDefaultBoxShadow,
                                    color: Theme.of(
                                      context,
                                    ).inputDecorationTheme.fillColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.SETTINGS);
                                    },
                                    child: NotificationsBadge(
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Theme.of(
                                          context,
                                        ).appBarTheme.iconTheme!.color,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Hello, $name',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: const Color(0xFFA7AEC1)),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'My Action',
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: DashboardIcon(
                                    image: "expense.svg",
                                    text: "Expense Claims",
                                    onIconTap: () {
                                      Get.toNamed(Routes.EXPENSES);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DashboardIcon(
                                    image: "officechair.svg",
                                    text: "Log Task",
                                    onIconTap: () {
                                      Get.toNamed(Routes.SITES);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DashboardIcon(
                                    image: "addevent.svg",
                                    text: "Schedule",
                                    onIconTap: () {
                                      PreferencesManager.getInstance()
                                          .setStringValue(
                                            "clientStartDate",
                                            "",
                                          );
                                      PreferencesManager.getInstance()
                                          .setStringValue("clientEndDate", "");
                                      Get.toNamed(Routes.SCHEDULES);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: DashboardIcon(
                                    image: "teams.svg",
                                    text: "Teams",
                                    onIconTap: () {
                                      Get.toNamed(Routes.TEAMS);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DashboardIcon(
                                    image: "announcements.svg",
                                    text: "Announcements",
                                    onIconTap: () {
                                      Get.toNamed(Routes.ANNOUNCEMENTS);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DashboardIcon(
                                    image: "alarm.svg",
                                    text: "Clock In",
                                    onIconTap: () {
                                      Get.toNamed(Routes.TIMETRACKERLIST);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
                            Text(
                              dashboardController.announcement.isEmpty
                                  ? 'No announcements'
                                  : 'Announcements',
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20.w),
                            dashboardController.announcement.isEmpty
                                ? Center(
                                    child:
                                        Theme.of(context).brightness ==
                                            Brightness.light
                                        ? SvgPicture.asset(
                                            'assets/svgs/messages_empty_state_light.svg',
                                          )
                                        : SvgPicture.asset(
                                            'assets/svgs/messages_empty_state_dark.svg',
                                          ),
                                  )
                                : Container(
                                    height: 120.h,
                                    child: PageView.builder(
                                      onPageChanged: selectedPageIndex,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: dashboardController
                                          .announcement
                                          .length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            height: 80.h,
                                            margin: REdgeInsets.all(5.h),
                                            padding: REdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              boxShadow: kDefaultBoxShadow,
                                              color: kDarkPrimary,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.r),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 12.w),
                                                const BorderIcon(
                                                  image: "announcementblue.svg",
                                                ),
                                                SizedBox(width: 12.w),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        dashboardController
                                                            .announcement[index]
                                                            .title!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall!
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      SizedBox(height: 5.w),
                                                      Text(
                                                        dashboardController
                                                            .announcement[index]
                                                            .description!,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      SizedBox(width: 8.w),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    ),
                                  ),
                            Center(
                              child: Container(
                                height: 20.0,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      dashboardController.announcement.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        return Obx(() {
                                          return Container(
                                            margin: const EdgeInsets.all(4),
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color:
                                                  selectedPageIndex.value ==
                                                      index
                                                  ? kDarkPrimary
                                                  : Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          );
                                        });
                                      },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
