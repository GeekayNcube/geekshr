import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/views/_components/header.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../controllers/changePasswordController.dart';
import '../../_components/c_elevated_button.dart';
import '../../_components/c_text_form_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangePasswordController changePasswordController =
        Get.isRegistered<ChangePasswordController>()
        ? Get.find<ChangePasswordController>()
        : Get.put(ChangePasswordController());

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
                const Header(title: "Change Password"),
                SizedBox(height: 30.h),
                Text(
                  'Current Password',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Consumer<PasswordProvider>(
                  builder: (context, pp, child) {
                    return CTextFormField(
                      onChanged: changePasswordController.password,
                      obscureText: pp.isObscure,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter your password',
                      prefixIcon:
                          Theme.of(context).brightness == Brightness.light
                          ? SvgPicture.asset('assets/svgs/lock_icon_light.svg')
                          : SvgPicture.asset('assets/svgs/lock_icon_dark.svg'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          pp.toggleIsObscure();
                        },
                        icon: Icon(
                          pp.isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'New Password',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Consumer<PasswordProvider>(
                  builder: (context, pp, child) {
                    return CTextFormField(
                      onChanged: changePasswordController.newPassword,
                      obscureText: pp.isObscure,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter your password',
                      prefixIcon:
                          Theme.of(context).brightness == Brightness.light
                          ? SvgPicture.asset('assets/svgs/lock_icon_light.svg')
                          : SvgPicture.asset('assets/svgs/lock_icon_dark.svg'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          pp.toggleIsObscure();
                        },
                        icon: Icon(
                          pp.isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'Verify Password',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Consumer<PasswordProvider>(
                  builder: (context, pp, child) {
                    return CTextFormField(
                      onChanged: changePasswordController.confirmPassword,
                      obscureText: pp.isObscure,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter your password',
                      prefixIcon:
                          Theme.of(context).brightness == Brightness.light
                          ? SvgPicture.asset('assets/svgs/lock_icon_light.svg')
                          : SvgPicture.asset('assets/svgs/lock_icon_dark.svg'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          pp.toggleIsObscure();
                        },
                        icon: Icon(
                          pp.isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 50.h),
                CElevatedButton(
                  child: const Text('Change Password'),
                  onPressed: () async {
                    await changePasswordController.changePassword();
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
}
