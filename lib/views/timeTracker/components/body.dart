import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/timeTrackerController.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../_components/c_dropdown_b.dart';
import '../../_components/c_elevated_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    TimeTrackerController timeTrackerController = TimeTrackerController();

    return FutureBuilder(
      future: timeTrackerController.getData(), // async work

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
              body: Obx(() {
                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    RPadding(
                      padding: REdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          const Header(title: 'Tracker'),
                          SizedBox(height: 36.h),
                          timeTrackerController.times.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: timeTrackerController.times.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {
                                      if (timeTrackerController
                                              .times[index]
                                              .checkedOut! ==
                                          false) {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.0),
                                            ),
                                          ),
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 20,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.lock_clock_sharp,
                                                      color: kDarkPrimary,
                                                    ),
                                                    title: const Text(
                                                      'Clock Out',
                                                    ),
                                                    onTap: () async {
                                                      var timer =
                                                          timeTrackerController
                                                              .times[index];
                                                      timeTrackerController
                                                              .timeTrackerId =
                                                          timer.timeTrackerId!;
                                                      await timeTrackerController
                                                          .checkIn(false);
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    title: const Text('Close'),
                                                    onTap: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        margin: REdgeInsets.only(bottom: 5.h),
                                        padding: REdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 10.h,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: kDefaultBoxShadow,
                                          color: Theme.of(
                                            context,
                                          ).inputDecorationTheme.fillColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: REdgeInsets.all(
                                                0,
                                              ),
                                              leading: const Icon(
                                                Icons.lock_clock,
                                                color: kDarkPrimary,
                                                size: 40,
                                              ),
                                              title: Text(
                                                timeTrackerController
                                                    .times[index]
                                                    .site!,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineSmall,
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(
                                                    textAlign: TextAlign.left,
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Check in : ${timeTrackerController.times[index].checkIn!}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '\nCheck out : ${timeTrackerController.times[index].checkOut!}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '\nStatus : ${timeTrackerController.times[index].status!}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3),
                                                ],
                                              ),
                                              trailing: const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: kDarkPrimary,
                                                size: 30,
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SvgPicture.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? 'assets/svgs/messages_empty_state_light.svg'
                                      : "messages_empty_state_dark.svg",
                                ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              floatingActionButton: InkWell(
                onTap: () async {
                  await timeTrackerController.getSiteNear();
                  if (timeTrackerController.sites.isNotEmpty) {
                    await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 270,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Check in",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 20),
                                  CDropdownButtonFormField(
                                    hintText: "Select Location",
                                    items:
                                        timeTrackerController.sitesDropDownlist,
                                    prefixIcon: const Icon(Icons.location_city),
                                    onChanged: (data) {
                                      timeTrackerController.siteId = int.parse(
                                        data,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    width: 200,
                                    child: CElevatedButton(
                                      child: const Text('Continue'),
                                      onPressed: () async {
                                        timeTrackerController.timeTrackerId = 0;
                                        await timeTrackerController.checkIn(
                                          true,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: REdgeInsets.only(
                    top: 10.w,
                    bottom: 10.w,
                    left: 10.w,
                    right: 10.h,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: kDefaultBoxShadow,
                    color: kDarkPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 30.0),
                ),
              ),
            );
        }
      },
    );
  }
}
