import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../config/dark_theme.dart';
import '../../../controllers/leaveApplicationController.dart';
import '../../_components/c_dropdown_b.dart';
import '../../_components/c_elevated_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveApplicationController leaveApplicationController =
        LeaveApplicationController();

    Future pickDateRange() async {
      DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: leaveApplicationController.applicationRange.value,
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
      leaveApplicationController.applicationRange = newDateRange.obs;
      leaveApplicationController.dateSelectControl.text =
          '${leaveApplicationController.applicationRange.value.start.day}/${leaveApplicationController.applicationRange.value.start.month}/${leaveApplicationController.applicationRange.value.start.year}  to ${leaveApplicationController.applicationRange.value.end.day}/${leaveApplicationController.applicationRange.value.end.month}/${leaveApplicationController.applicationRange.value.end.year}';
      leaveApplicationController.update();
    }

    return FutureBuilder(
      future: leaveApplicationController.getLeaveType(), // async work

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
                        const Header(title: 'Leave Application'),
                        SizedBox(height: 36.h),
                        CDropdownButtonFormField(
                          items: leaveApplicationController
                              .leaveApplicationTypesData,
                          onChanged: (data) {
                            leaveApplicationController.leaveApplicationTypeId =
                                int.parse(data).obs;
                          },
                          hintText: "Type of leave",
                        ),
                        SizedBox(height: 20.h),
                        ListTile(
                          contentPadding: REdgeInsets.all(0),
                          title: Text(
                            'Number of days',
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            'Excluding holidays ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: SizedBox(
                            width: 80.w,
                            child: Obx(() {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      leaveApplicationController.numberOfDays >
                                              0
                                          ? leaveApplicationController
                                                .numberOfDays--
                                          : leaveApplicationController
                                                .numberOfDays;
                                    },
                                    child: Container(
                                      padding: REdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Theme.of(context).brightness ==
                                                Brightness.light
                                            ? const Color(0xFFE7E7E7)
                                            : const Color(0xFF636777),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Theme.of(
                                          context,
                                        ).appBarTheme.iconTheme!.color,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    leaveApplicationController.numberOfDays
                                        .toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      leaveApplicationController.numberOfDays++;
                                    },
                                    child: Container(
                                      padding: REdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kBlueColor,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: kWhiteColor,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          onTap: () async {
                            //pickDateRange
                            await pickDateRange();
                          },
                          controller:
                              leaveApplicationController.dateSelectControl,
                          readOnly: true,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              top: 30,
                            ), // add padding to adjust text
                            isDense: true,
                            hintText: "Dates",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                                left: 15,
                                right: 15,
                              ), // add padding to adjust icon
                              child: SvgPicture.asset(
                                'assets/svgs/calender_icon.svg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextField(
                          controller:
                              leaveApplicationController.noteSelectControl,
                          maxLines: 8, //or null
                          decoration: const InputDecoration(
                            hintText: "Enter your notes here",
                          ),
                        ),
                        SizedBox(height: 30.h),
                        CElevatedButton(
                          child: const Text('Request'),
                          onPressed: () async {
                            await leaveApplicationController.sendRequest();
                          },
                        ),
                        SizedBox(height: 20.h),
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
