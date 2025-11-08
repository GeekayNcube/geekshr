import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/siteController.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../util/MapUtils.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    SitesController sitesController = SitesController();

    return FutureBuilder(
      future: sitesController.getSiteNear(), // async work

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
                          const Header(title: 'Sites Near Me'),
                          SizedBox(height: 36.h),
                          sitesController.sites.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: sitesController.sites.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {
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
                                                    Icons.person,
                                                    color: kDarkPrimary,
                                                  ),
                                                  title: const Text(
                                                    'View clients',
                                                  ),
                                                  onTap: () async {
                                                    Get.toNamed(
                                                      Routes.CLIENTS,
                                                      arguments: [
                                                        sitesController
                                                            .sites[index]
                                                            .siteId,
                                                      ],
                                                    );
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                    Icons.location_on,
                                                    color: kDarkPrimary,
                                                  ),
                                                  title: const Text(
                                                    'Go to site',
                                                  ),
                                                  onTap: () async {
                                                    await MapUtils.openMap(
                                                      sitesController
                                                          .sites[index]
                                                          .address!,
                                                    );
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                  title: const Text('Close'),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: Container(
                                        margin: REdgeInsets.only(bottom: 5.h),
                                        padding: REdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: kDefaultBoxShadow,
                                          color: Theme.of(
                                            context,
                                          ).inputDecorationTheme.fillColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.r),
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
                                                Icons.account_circle,
                                                color: kDarkPrimary,
                                                size: 40,
                                              ),
                                              title: Text(
                                                sitesController
                                                    .sites[index]
                                                    .description!,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge,
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 1.h,
                                                ),
                                                child: Text(
                                                  sitesController
                                                      .sites[index]
                                                      .address!,
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyLarge,
                                                ),
                                              ),
                                              trailing: const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: kDarkPrimary,
                                                size: 30,
                                              ),
                                            ),
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
            );
        }
      },
    );
  }
}
