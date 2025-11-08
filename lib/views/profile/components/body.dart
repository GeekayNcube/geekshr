import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/config/constants.dart';
import 'package:geekshr/views/_components/header.dart';

import '../../../util/preferences_manager.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    var firstName = PreferencesManager.getInstance().getStringValue(
      "firstName",
    );
    var lastName = PreferencesManager.getInstance().getStringValue("lastName");
    var email = PreferencesManager.getInstance().getStringValue("email");
    var IDNumber = PreferencesManager.getInstance().getStringValue("IDNumber");
    var IDExpirydate = PreferencesManager.getInstance().getStringValue(
      "IDExpirydate",
    );
    var DOB = PreferencesManager.getInstance().getStringValue("DOB");
    var profileLink = PreferencesManager.getInstance().getStringValue(
      "profileLink",
    );
    var contractStartDate = PreferencesManager.getInstance().getStringValue(
      "contractStartDate",
    );
    var mobileNumber = PreferencesManager.getInstance().getStringValue(
      "mobileNumber",
    );

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
                const Header(title: "My Profile"),
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
                      firstName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      lastName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      mobileNumber.isEmpty ? 'Not Available' : mobileNumber,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      'Email',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      email.isEmpty ? 'Not Available' : email,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      'ID No /Passport',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      IDNumber.isEmpty ? 'Not Available' : IDNumber,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      'DOB',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      DOB.isEmpty ? 'Not Available' : DOB,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      'ID Expiry date',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      IDExpirydate.isEmpty ? 'N/A' : IDExpirydate,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
                      'Contract Start Date',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      contractStartDate.isEmpty
                          ? 'Not available'
                          : contractStartDate,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
