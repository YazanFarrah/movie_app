import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

import 'custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor = Colors.transparent,
    this.leading,
    this.centerTitle = false,
    this.bottom,
    this.flexibleSpace,
    this.popPath,
    this.popOnePage,
    this.onBack,
    this.actions,
    this.systemUI,
    this.titleHeroTag,
    this.leadingWidth,
    this.padding,
    this.titleColor,
    this.titleWidget,
  });

  final String? title;
  final Widget? titleWidget;
  final Color? titleColor;
  final SystemUiOverlayStyle? systemUI;
  final Color backgroundColor;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final String? popPath;
  final bool? popOnePage;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final String? titleHeroTag;
  final double? leadingWidth;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 20.w),
      child: AppBar(
        scrolledUnderElevation: 0,
        systemOverlayStyle: systemUI ?? SystemUiOverlayStyle.dark,
        actions: actions,
        flexibleSpace: flexibleSpace,
        leadingWidth: leadingWidth ?? 12.w,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        leading: leading ??
            IconButton(
              padding: EdgeInsets.zero,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: onBack ??
                  () {
                    Get.back();
                  },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
        title: titleHeroTag != null
            ? Hero(
                tag: titleHeroTag!,
                child: titleWidget ??
                    CustomTextWidget(
                      text: title ?? "",
                      fontSize: 18,
                    ),
              )
            : titleWidget ??
                CustomTextWidget(
                  text: title ?? "",
                  fontSize: 18,
                  color: titleColor,
                ),
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
