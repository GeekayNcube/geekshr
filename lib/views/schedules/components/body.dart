import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';
import '../../../config/dark_theme.dart';
import '../../../controllers/ScheduleController.dart';
import '../../../util/MapUtils.dart';
import '../../../util/preferences_manager.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleController scheduleController = ScheduleController();

    var startDate = DateTime.now().subtract(const Duration(days: 1));
    var endDate = DateTime.now().add(const Duration(days: 3));
    var clientStartDate =
        PreferencesManager.getInstance().getStringValue("clientStartDate");
    var clientEndDate =
        PreferencesManager.getInstance().getStringValue("clientEndDate");
    if (clientStartDate.isNotEmpty) {
      startDate = DateTime.parse(clientStartDate);
    }
    if (clientEndDate.isNotEmpty) {
      endDate = DateTime.parse(clientEndDate);
    }
    var dateTimeRange = DateTimeRange(
      start: startDate,
      end: endDate,
    ).obs;

    Future pickDateRange() async {
      DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateTimeRange.value,
        firstDate: DateTime(2023),
        lastDate: DateTime(2031),
        saveText: 'Select Date',
        cancelText: "Cancel",
        confirmText: "Done",
        builder: (context, child) {
          return Theme(data: darkTheme, child: child!);
        },
      );
      if (newDateRange == null) {
        return; //pressed x/ calcel
      }

      dateTimeRange = newDateRange.obs;

      await scheduleController.getData(
          dateTimeRange.value.start, dateTimeRange.value.end);
      scheduleController.update();
    }

    return FutureBuilder(
        future: scheduleController.getData(
            dateTimeRange.value.start, dateTimeRange.value.end), // async work

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
                body: Obx(
                  () {
                    return ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        RPadding(
                          padding: REdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const BackButton(),
                                  Expanded(
                                    child: Text(
                                      'My Schedules',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await pickDateRange();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(15.r),
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.date_range),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 36.h,
                              ),
                              scheduleController.schedules.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          scheduleController.schedules.length,
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            25.0)),
                                              ),
                                              builder: (BuildContext context) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          bottom: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: const Icon(
                                                          Icons.person,
                                                          color: kDarkPrimary,
                                                        ),
                                                        title: const Text(
                                                            'Clients'),
                                                        onTap: () async {
                                                          PreferencesManager
                                                                  .getInstance()
                                                              .setStringValue(
                                                                  "clientStartDate",
                                                                  dateTimeRange
                                                                      .value
                                                                      .start
                                                                      .toIso8601String());
                                                          PreferencesManager
                                                                  .getInstance()
                                                              .setStringValue(
                                                                  "clientEndDate",
                                                                  dateTimeRange
                                                                      .value.end
                                                                      .toIso8601String());
                                                          Get.toNamed(
                                                              Routes.CLIENTS,
                                                              arguments: [
                                                                scheduleController
                                                                    .schedules[
                                                                        index]
                                                                    .site!
                                                                    .siteId!
                                                              ]);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                          Icons.navigation,
                                                          color: kDarkPrimary,
                                                        ),
                                                        title: const Text(
                                                            'Go to site'),
                                                        onTap: () async {
                                                          await MapUtils.openMap(
                                                              scheduleController
                                                                  .schedules[
                                                                      index]
                                                                  .site!
                                                                  .address!);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                          Icons.location_on,
                                                          color: kDarkPrimary,
                                                        ),
                                                        title: const Text(
                                                            'View site address'),
                                                        onTap: () async {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: const Text(
                                                                            'Address'),
                                                                        content: Text(scheduleController
                                                                            .schedules[index]
                                                                            .site!
                                                                            .address!),
                                                                      ));
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                        title:
                                                            const Text('Close'),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                          padding: REdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          margin:
                                              REdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                              boxShadow: kDefaultBoxShadow,
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .fillColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.r)),
                                              border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.transparent)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month,
                                                    color: kDarkPrimary,
                                                    size: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          scheduleController
                                                              .schedules[index]
                                                              .site!
                                                              .description!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text.rich(
                                                          textAlign:
                                                              TextAlign.left,
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      'FROM : ',
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kBlueColor,
                                                                  )),
                                                              TextSpan(
                                                                  text: scheduleController
                                                                      .schedules[
                                                                          index]
                                                                      .startDateFormatted!,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium),
                                                              TextSpan(
                                                                  text:
                                                                      '\nTO       : ',
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kBlueColor,
                                                                  )),
                                                              TextSpan(
                                                                  text: scheduleController
                                                                      .schedules[
                                                                          index]
                                                                      .endDateFormatted!,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: kDarkPrimary,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SvgPicture.asset(Theme.of(context)
                                              .brightness ==
                                          Brightness.light
                                      ? 'assets/svgs/messages_empty_state_light.svg'
                                      : "messages_empty_state_dark.svg")
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
          }
        });
  }
}
