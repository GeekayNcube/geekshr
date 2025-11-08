import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/expenseClaimController.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseClaimController expenseClaimController = ExpenseClaimController();

    return FutureBuilder(
      future: expenseClaimController.getData(), // async work

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
                          const Header(title: 'Expense Claims'),
                          SizedBox(height: 36.h),
                          expenseClaimController.expenseClaims.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: expenseClaimController
                                      .expenseClaims
                                      .length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {},
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
                                                Icons.attach_money,
                                                color: kDarkPrimary,
                                                size: 30,
                                              ),
                                              title: Text(
                                                expenseClaimController
                                                    .expenseClaims[index]
                                                    .title!,
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
                                                              'Date : ${expenseClaimController.expenseClaims[index].expenseDate!}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '\nStatus : ${expenseClaimController.expenseClaims[index].expenseClaimStatus!}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3),
                                                  Text(
                                                    '£ ${expenseClaimController.expenseClaims[index].amount!.toStringAsFixed(2)!}',
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.headlineSmall,
                                                  ),
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
                onTap: () {
                  Get.toNamed(Routes.EXPENSECLAIMMAINTAIN);
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
