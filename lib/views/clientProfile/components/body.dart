import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/config/constants.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';

import '../../../controllers/clientController.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ClientController clientController = ClientController();
    var data = Get.arguments;

    int clientId = data[0];
    return FutureBuilder(
      future: clientController.getClient(clientId), // async work

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(title: "Client Profile"),
                        SizedBox(height: 30.h),
                        Center(
                          child: SvgPicture.asset(
                            'assets/svgs/accountProfile.svg',
                            color: kLightPrimary,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              clientController.clientDetailDto.firstName!,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Surname',
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              clientController.clientDetailDto.surname!,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mobile Number',
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              clientController
                                      .clientDetailDto
                                      .mobileNumber!
                                      .isEmpty
                                  ? 'Not Available'
                                  : clientController
                                        .clientDetailDto
                                        .mobileNumber!,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        Text(
                          'About Client',
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          clientController.clientDetailDto.about!,
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: clientController
                              .clientDetailDto
                              .medications!
                              .length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {},
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      contentPadding: REdgeInsets.all(0),
                                      leading: const Icon(
                                        Icons.mediation,
                                        color: kDarkPrimary,
                                        size: 30,
                                      ),
                                      title: Text(
                                        clientController
                                            .clientDetailDto
                                            .medications![index]
                                            .description!,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      subtitle: Padding(
                                        padding: EdgeInsets.only(top: 1.h),
                                        child: Text(
                                          'Quantity ${clientController.clientDetailDto.medications![index].quantity}',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
