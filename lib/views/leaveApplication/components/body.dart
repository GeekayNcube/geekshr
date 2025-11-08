import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../controllers/leaveApplicationController.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveApplicationController leaveApplicationController =
        LeaveApplicationController();

    return FutureBuilder(
      future: leaveApplicationController.getData(), // async work

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
                          const Header(title: 'Leave Application'),
                          SizedBox(height: 36.h),
                          leaveApplicationController.leaves.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      leaveApplicationController.leaves.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {
                                      if (leaveApplicationController
                                              .leaves[index]
                                              .leaveApplicationStatus!
                                              .toLowerCase() ==
                                          "pending") {
                                        await showAlertDialog(
                                          context,
                                          leaveApplicationController,
                                          leaveApplicationController
                                              .leaves[index]
                                              .leaveApplicationId!,
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
                                              leading: SvgPicture.asset(
                                                'assets/svgs/clock_dark_icon.svg',
                                                color:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.light
                                                    ? Colors.grey
                                                    : Colors.white,
                                              ),
                                              title: Text(
                                                '${leaveApplicationController.leaves[index].numberOfDays} day (s)',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineMedium,
                                              ),
                                              subtitle: Text.rich(
                                                textAlign: TextAlign.left,
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'From : ${leaveApplicationController.leaves[index].startDate!}\n',
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyMedium,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'To : ${leaveApplicationController.leaves[index].endDate!}',
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyMedium,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '\nStatus : ${leaveApplicationController.leaves[index].leaveApplicationStatus!}',
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyMedium,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '\n${leaveApplicationController.leaves[index].leaveApplicationType!}',
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyMedium,
                                                    ),
                                                  ],
                                                ),
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
                onTap: () {
                  Get.toNamed(Routes.REQUESTLEAVEAPPLICATION);
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

  showAlertDialog(
    BuildContext context,
    LeaveApplicationController leaveApplicationController,
    int leaveApplicationId,
  ) {
    // set up the buttons

    Widget cancelButton = InkWell(
      child: const Padding(
        padding: EdgeInsets.only(left: 10.0, right: 15.0, bottom: 10.0),
        child: Text("No"),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = InkWell(
      child: const Padding(
        padding: EdgeInsets.only(left: 10.0, right: 15.0, bottom: 10.0),
        child: Text("Yes"),
      ),
      onTap: () async {
        await leaveApplicationController.cancelLeave(leaveApplicationId);
        Navigator.of(context).pop();
        Get.toNamed(Routes.DASHBOARD);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Cancel Leave"),
      content: const Text("Are you sure you want to cancel this leave?"),
      actions: [cancelButton, launchButton],
    );
    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
