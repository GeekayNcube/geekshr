import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekshr/controllers/welcomeController.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../config/constants.dart';
import '../../_components/c_elevated_button.dart';
import '../../routes/routes.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomeController welcomeController = Get.isRegistered<WelcomeController>()
        ? Get.find<WelcomeController>()
        : Get.put(WelcomeController());

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.9,
                    height: Get.height * 0.75,
                    child: const _onBoarding(),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * .6,
                        height: Get.height * .07,
                        child: CElevatedButton(
                          child: const Text('Login'),
                          onPressed: () async {
                            Get.offAllNamed(Routes.SIGNIN);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _onBoarding extends StatelessWidget {
  const _onBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Easy Access',
          body:
              'Cloud Base Social HR solution for your business providing a lot of self service at their fingertips.',
          image: SvgPicture.asset(
            "assets/svgs/onboarding_1.svg",
            color: kDarkPrimary,
            semanticsLabel: 'F_1',
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Stay Connected',
          body:
              'Do not miss any important activities happening in your organisation.',
          image: SvgPicture.asset(
            "assets/svgs/onboarding_2.svg",
            color: kDarkPrimary,
            alignment: Alignment.bottomCenter,
            semanticsLabel: 'F_2',
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'No more paperwork',
          body:
              'Log all your expenses, tasks and time sheet using the mobile application.',
          image: SvgPicture.asset(
            "assets/svgs/onboarding_3.svg",
            color: kDarkPrimary,
            semanticsLabel: 'F_3',
          ),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text(
        '',
      ), //Text('Read', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => {},
      showSkipButton: true,
      skip: const Text(''),
      onSkip: () => {},
      next: const Text(''), //Icon(Icons.arrow_forward),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => {}, //print('Page $index selected'),
      //Theme.of(context).primaryColor,
      dotsFlex: 0,
      nextFlex: 0,
      // isProgressTap: false,
      // isProgress: false,
      // showNextButton: false,
      // freeze: true,
      animationDuration: 1000,
    ),
  );

  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Colors.grey, //Color(0xFFEEC850),
    activeColor: kDarkPrimary,
    size: const Size(20, 20),
    activeSize: const Size(32, 20),
    spacing: const EdgeInsets.all(25),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
    bodyPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
    //descriptionPadding:
    imagePadding: const EdgeInsets.all(24),

    //bodyAlignment: Alignment.bottomCenter,
    //imageAlignment: Alignment.center
  );
}
