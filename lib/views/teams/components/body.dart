import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../controllers/userController.dart';
import '../../../util/utilities.dart';
import '../../_components/search_text_field.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = UserController();

    return FutureBuilder(
      future: userController.search(), // async work

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
                          const Header(title: 'My Team'),
                          SizedBox(height: 36.h),
                          SearchTextField(
                            textControllor: userController.textControllor,
                            label: 'Search',
                            hintText: 'Search',
                            future: () async {
                              //userController.pageNumber = 0;
                              await userController.search();
                              userController.update();
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
                          userController.users.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: userController.users.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {},
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
                                                '${Utilities.capitalize(userController.users[index].firstName!)} '
                                                '${Utilities.capitalize(userController.users[index].lastName!)}',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge,
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 10.h,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      userController
                                                          .users[index]
                                                          .emailAddress!,
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyLarge,
                                                    ),
                                                    Text(
                                                      userController
                                                          .users[index]
                                                          .mobileNumber!,
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyLarge,
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
            );
        }
      },
    );
  }
}
