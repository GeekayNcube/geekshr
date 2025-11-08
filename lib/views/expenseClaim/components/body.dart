import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geekshr/controllers/expenseClaimController.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../_components/c_elevated_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseClaimController expenseClaimController = ExpenseClaimController();

    return FutureBuilder(
      future: expenseClaimController.getClaim(0), // async work

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            Text(
                              "Expense Claim",
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 400,
                                );
                                if (image != null) {
                                  var bytes = await image.readAsBytes();
                                  String base64Image = base64Encode(bytes);

                                  expenseClaimController.image = base64Image;
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 36.h),
                        TextField(
                          onChanged: expenseClaimController.title,
                          maxLines: 1, //or null
                          decoration: const InputDecoration(hintText: "Title"),
                        ),
                        SizedBox(height: 15.h),
                        TextField(
                          readOnly: true,
                          controller: expenseClaimController.date,
                          maxLines: 1, //or null
                          decoration: const InputDecoration(hintText: "Date"),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                2022,
                              ), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              expenseClaimController.transactionDateTime =
                                  pickedDate.obs;
                              String formattedDate = DateFormat(
                                'dd MMM yyyy',
                              ).format(pickedDate);

                              expenseClaimController.date.text = formattedDate;
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        TextField(
                          onChanged: expenseClaimController.amount,
                          maxLines: 1,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ), //or null
                          decoration: const InputDecoration(hintText: "Amount"),
                        ),
                        SizedBox(height: 15.h),
                        TextField(
                          onChanged: expenseClaimController.comments,
                          maxLines: 5, //or null
                          decoration: const InputDecoration(hintText: "Notes"),
                        ),
                        SizedBox(height: 20.h),
                        CElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () async {
                            await expenseClaimController.sendRequest();
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
