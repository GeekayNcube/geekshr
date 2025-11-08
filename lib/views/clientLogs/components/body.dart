import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/clientLogsController.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/constants.dart';
import '../../_components/c_dropdown_b.dart';
import '../../_components/c_elevated_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ClientLogsController clientLogsController = ClientLogsController();
    var data = Get.arguments;
    int clientId = data[0];

    var startDate = DateTime.now().subtract(const Duration(days: 3));
    var endDate = DateTime.now().add(const Duration(days: 1));

    var dateTimeRange = DateTimeRange(start: startDate, end: endDate).obs;

    return FutureBuilder(
      future: clientLogsController.getData(
        dateTimeRange.value.start,
        dateTimeRange.value.end,
        clientId,
      ), // async work

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
                          const Header(title: 'Client Logs'),
                          SizedBox(height: 36.h),
                          clientLogsController.clientLogs.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      clientLogsController.clientLogs.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () async {
                                      clientLogsController.notes = TextEditingController(text: clientLogsController
                                          .clientLogs[index]
                                          .notes);


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
                                              top: 20,
                                              bottom: 50,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[

                                                TextField(
                                                  controller: clientLogsController.notes,
                                                  maxLines: 3,
                                                  enabled: false,

                                                ),
                                                const SizedBox(height: 20),
                                                clientLogsController
                                                        .clientLogs[index]
                                                        .imageLink!
                                                        .isNotEmpty
                                                    ? Center(
                                                        child: Image.network(
                                                          clientLogsController
                                                              .clientLogs[index]
                                                              .imageLink!,
                                                          height: 300,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
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
                                                clientLogsController
                                                    .clientLogs[index]
                                                    .clientLogType!
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
                                                  "By :${clientLogsController.clientLogs[index].user!.firstName!} ${clientLogsController.clientLogs[index].user!.lastName!}",
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
              floatingActionButton: InkWell(
                onTap: () async {
                  await clientLogsController.getClientLogTypes();

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
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
                        child:
                        SingleChildScrollView( child:

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              "Fill in details",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 10),
                            CDropdownButtonFormField(
                              hintText: "Log Type",
                              items: clientLogsController.clientLogTypesData,
                              onChanged: (value) {
                                clientLogsController.clientTypeLogId =
                                    int.parse(value).obs;
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Notes",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: clientLogsController.notes,
                              maxLines: 3, //or null
                              decoration: const InputDecoration(
                                hintText: "Enter your notes here",
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    maxWidth: 400,
                                  );
                                  if (image != null) {
                                    var bytes = await image.readAsBytes();
                                    String base64Image = base64Encode(bytes);

                                    clientLogsController.image = base64Image;
                                  }
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.grey
                                        : Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: CElevatedButton(
                                  child: const Text('Save'),
                                  onPressed: () async {
                                    int resultId = await clientLogsController
                                        .save(clientId);
                                    if (resultId > 0) {
                                      Navigator.of(context).pop();
                                      await clientLogsController.getData(
                                        dateTimeRange.value.start,
                                        dateTimeRange.value.end,
                                        clientId,
                                      );
                                      clientLogsController.update();
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 20),
                          ],
                        ),
                        ),
                      );
                    },
                  );
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
