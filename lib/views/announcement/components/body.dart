import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/config/constants.dart';
import 'package:geekshr/controllers/announcementController.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../_components/search_text_field.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    AnnouncementController announcementController = AnnouncementController();

    return FutureBuilder(
      future: announcementController.getData(), // async work

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
                          const Header(title: 'Announcements'),
                          SizedBox(height: 36.h),
                          SearchTextField(
                            textControllor:
                                announcementController.textControllor,
                            label: 'Search',
                            hintText: 'Search',
                            future: () async {
                              await announcementController.getData();
                              announcementController.update();
                            },
                            prefixIcon:
                                Theme.of(context).brightness == Brightness.light
                                ? SvgPicture.asset(
                                    'assets/svgs/search_icon_light.svg',
                                  )
                                : SvgPicture.asset(
                                    'assets/svgs/search_icon_light.svg',
                                  ),
                          ),
                          SizedBox(height: 20.h),
                          announcementController.announcement.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: announcementController
                                      .announcement
                                      .length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      ListTile(
                                        onTap: () async {
                                          Get.toNamed(
                                            Routes.ANNOUNCEMENTSDETAIL,
                                            arguments: [
                                              announcementController
                                                  .announcement[index]
                                                  .title!,
                                              announcementController
                                                  .announcement[index]
                                                  .description!,
                                              announcementController
                                                  .announcement[index]
                                                  .startDateFormated!,
                                            ],
                                          );
                                        },
                                        //kLightTextColor
                                        contentPadding: REdgeInsets.all(0),
                                        leading: SvgPicture.asset(
                                          'assets/svgs/messages_icon_light.svg',
                                          fit: BoxFit.fill,
                                          height: 25,
                                          color: kDarkPrimary,
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                announcementController
                                                    .announcement[index]
                                                    .title!,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.headlineSmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                announcementController
                                                    .announcement[index]
                                                    .description!,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: kDarkPrimary,
                                          size: 25,
                                        ),
                                      ),
                                      const Divider(),
                                    ],
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
            );
        }
      },
    );
  }
}
