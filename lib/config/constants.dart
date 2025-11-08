import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

const Color kLightPrimary = Color(0xff46cdfb);
const Color kDarkPrimary = Color(0xFF5669FF);

const Color kLightBackground = Color(0xFFFFFFFF);
const Color kDarkBackground = Color(0xFF111315);

const Color kLightTextColor = Color(0xFFA7AEC1);
const Color kDarkTextColor = Color(0xFF808080);

const Color elevatedButtonTextColor = Color(0xFFFFFFFF);

const Color kLightFillColor = Color(0xFFFFFFFF);
const Color kDarkFillColor = Color(0xFF292E32);

const Color kLightHintTextColor = Color(0xFFA7AEC1);
const Color kDarkHintTextColor = Color(0xFF8A8D99);

const Color kLightStrokeColor = Color(0xFFD9D9D9);
const Color kDarkStrokeColor = Color(0xFF1D2839);

const Color kLightDividerColor = Color(0xFFDFE2EB);
const Color kDarkDividerColor = Color(0xFF292E32);

const Color kBlueColor = Color(0xFF235784);
const Color kYellowColor = Color(0xFFFFBA55);
const Color kRedColor = Color(0xFFC70039);
const Color kWhiteColor = Colors.white;
const Color kGreenColor = Color(0xFF13B97D);

List<BoxShadow> kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 16,
    offset: const Offset(0, -4),
  ),
];

String timeAgoCustom(DateTime d) {
  // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')     // WhatsApp Time Show Status Shimila
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  } else if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  } else if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  } else if (diff.inDays > 0) {
    return DateFormat.E().add_d().format(d);
  } else if (diff.inHours > 0) {
    return "Today";
  } else if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

final kLightInputFocusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: const BorderSide(color: kBlueColor, width: 1));

final kLightInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: const BorderSide(color: Color(0xFFE2E4EA), width: 1));

final kDarkInputFocusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: const BorderSide(color: kBlueColor, width: 1));

final kDarkInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: const BorderSide(color: Color(0xFF202427), width: 1));
