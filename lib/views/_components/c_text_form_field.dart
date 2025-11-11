// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CTextFormField extends StatelessWidget {
  final TextEditingController? textControllor;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool? showCursor;
  void Function()? onTap;
  final String? Function(String?)? validator;
  void Function(String?)? onSaved;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final ToolbarOptions? toolbarOptions;
  final int maxLines;
  CTextFormField({
    super.key,
    this.textControllor,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.showCursor,
    this.onTap,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onChanged,
    this.maxLines = 1,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.toolbarOptions,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textControllor,
      // if a controller is provided, don't pass initialValue (invalid to provide both)
      initialValue: textControllor == null ? initialValue : null,
      decoration: InputDecoration(
        // only provide prefixIcon padding when an icon exists
        prefixIcon: prefixIcon != null
            ? Padding(
          padding:
          REdgeInsets.symmetric(vertical: 17.h, horizontal: 14.w),
          child: prefixIcon,
        )
            : null,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.titleMedium,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      showCursor: showCursor,
      onTap: onTap,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLines: maxLines,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      toolbarOptions: toolbarOptions,
    );
  }
}
