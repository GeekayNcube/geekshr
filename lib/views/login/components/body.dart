import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geekshr/controllers/signInController.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../config/constants.dart';
import '../../../../main.dart';
import '../../../util/preferences_manager.dart';
import '../../_components/c_elevated_button.dart';
import '../../_components/c_text_form_field.dart';

class Body extends GetView<SignInController> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var username = PreferencesManager.getInstance().getStringValue("username");

    if (username.isNotEmpty) {
      controller.usernameController = TextEditingController(
        text: username,
      );
    }
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: REdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 10.h),
            Center(
              child: SizedBox(
                width: 200.h,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(height: 12.h),
            Text(
              'Please login to your account',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 40.h),
            Text(
              'Username',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            CTextFormField(
              hintText: 'Enter your user name',
              textControllor: controller.usernameController,
              textInputAction: TextInputAction.next,
              prefixIcon: Theme.of(context).brightness == Brightness.light
                  ? SvgPicture.asset('assets/svgs/user_light_icon.svg')
                  : SvgPicture.asset('assets/svgs/user_dark_icon.svg'),
            ),
            SizedBox(height: 20.h),
            Text(
              'Password',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            Consumer<PasswordProvider>(
              builder: (context, pp, child) {
                return CTextFormField(
                  textControllor: controller.passwordController,
                  //..text = 'test421',
                  obscureText: pp.isObscure,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  hintText: 'Enter your password',
                  prefixIcon: Theme.of(context).brightness == Brightness.light
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
            SizedBox(height: 15.h),
            InkWell(
              onTap: () async {
                await controller.forgotPassword();
              },
              child: Text(
                'Forgot Password?',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: kBlueColor),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 30.h),
            CElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                await controller.login();
              },
            ),
            SizedBox(height: 20.h),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
