import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        Container(
          padding: EdgeInsets.all(15.r),
          decoration: const BoxDecoration(
              color: Colors.transparent, shape: BoxShape.circle),
        ),
      ],
    );
  }
}
