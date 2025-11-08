import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/clientController.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../util/utilities.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ClientController clientController = ClientController();
    var data = Get.arguments;
    int siteId = data[0];
    return FutureBuilder(
      future: clientController.getData(siteId), // async work

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
                          const Header(title: 'Clients'),
                          SizedBox(height: 36.h),
                          clientController.clients.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: clientController.clients.length,
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
                                                    'View Profile',
                                                  ),
                                                  onTap: () async {
                                                    Get.toNamed(
                                                      Routes.CLIENTPROFILE,
                                                      arguments: [
                                                        clientController
                                                            .clients[index]
                                                            .clientId,
                                                      ],
                                                    );
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                    Icons.local_activity,
                                                    color: kDarkPrimary,
                                                  ),
                                                  title: const Text(
                                                    'Client Logs',
                                                  ),
                                                  onTap: () async {
                                                    Get.toNamed(
                                                      Routes.CLIENTLOGS,
                                                      arguments: [
                                                        clientController
                                                            .clients[index]
                                                            .clientId,
                                                      ],
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
                                                '${Utilities.capitalize(clientController.clients[index].firstName!)} '
                                                '${Utilities.capitalize(clientController.clients[index].surname!)}',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge,
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 1.h,
                                                ),
                                                child: const SizedBox.shrink(),
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
