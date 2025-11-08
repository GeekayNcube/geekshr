import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/views/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/constants.dart';
import 'dashboard/dashboard.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  List<Widget> get _children => [
    const DashboardPage(),
    const SettingsPage(),
    const SettingsPage(),
  ];

  onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [Expanded(child: _children[currentIndex])]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        selectedItemColor: kBlueColor,
        selectedIconTheme: const IconThemeData(color: kBlueColor),
        unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        unselectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        selectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: kBlueColor,
        ),
        elevation: 6,
        items: [
          BottomNavigationBarItem(
            icon: Theme.of(context).brightness == Brightness.light
                ? SvgPicture.asset(
                    'assets/svgs/home_icon_light.svg',
                    color: currentIndex == 0
                        ? kBlueColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  )
                : SvgPicture.asset(
                    'assets/svgs/home_icon_dark.svg',
                    color: currentIndex == 0
                        ? kBlueColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Theme.of(context).brightness == Brightness.light
                ? SvgPicture.asset(
                    'assets/svgs/messages_icon_light.svg',
                    color: currentIndex == 2
                        ? kBlueColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  )
                : SvgPicture.asset(
                    'assets/svgs/messages_icon_dark.svg',
                    color: currentIndex == 2
                        ? kBlueColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  ),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Theme.of(context).brightness == Brightness.light
                ? SvgPicture.asset(
                    'assets/svgs/user_light_icon.svg',
                    color: currentIndex == 3
                        ? kBlueColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  )
                : SvgPicture.asset(
                    'assets/svgs/user_dark_icon.svg',
                    color: currentIndex == 3
                        ? kBlueColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
