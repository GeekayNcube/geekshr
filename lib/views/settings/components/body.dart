import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/views/_components/menuButton.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../controllers/profileController.dart';
import '../../_components/header.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
    return Scaffold(
      body: ListView(
        children: [
          RPadding(
            padding: REdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(title: 'Account Settings'),
                SizedBox(height: 30.h),
                MenuButton(
                  image: "user_icon_light.svg",
                  title: "My Profile",
                  onTap: () {
                    Get.toNamed(Routes.EDITPROFILE);
                  },
                ),
                SizedBox(height: 15.h),
                MenuButton(
                  image: "lock_icon_light.svg",
                  title: "Change Password",
                  onTap: () {
                    Get.toNamed(Routes.ChangePaswordPage);
                  },
                ),
                SizedBox(height: 15.h),
                MenuButton(
                  image: "clock_dark_icon.svg",
                  title: "My Leave",
                  onTap: () {
                    Get.toNamed(Routes.LEAVEAPPLICATION);
                  },
                ),
                SizedBox(height: 15.h),
                MenuButton(
                  image: "visibility_off_dark.svg",
                  title: "Delete My Profile",
                  onTap: () {
                    showAlertDialog(context, profileController);
                  },
                ),
                SizedBox(height: 15.h),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    boxShadow: kDefaultBoxShadow,
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.offAllNamed(Routes.SIGNIN);
                    },
                    contentPadding: REdgeInsets.all(0),
                    leading: SvgPicture.asset('assets/svgs/logout_icon.svg'),
                    title: Text(
                      'Log Out',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: const Color(0xFFFF4747),
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

  showAlertDialog(BuildContext context, ProfileController profileController) {
    // set up the buttons

    Widget cancelButton = InkWell(
      child: const Text("Cancel"),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = InkWell(
      child: const Text("Delete"),
      onTap: () async {
        await profileController.delete();
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete profile"),
      content: const Text("Are you sure you want to delete?"),
      actions: [cancelButton, launchButton],
    );
    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
