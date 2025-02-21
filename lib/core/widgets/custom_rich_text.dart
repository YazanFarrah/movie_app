import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String clickableText;
  final Function()? onTap;
  final Color? clickableTextColor;

  const CustomRichText({
    super.key,
    this.clickableTextColor,
    required this.firstText,
    required this.clickableText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$firstText ",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          TextSpan(
            text: clickableText,
            style: TextStyle(
              color: clickableTextColor ?? Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
