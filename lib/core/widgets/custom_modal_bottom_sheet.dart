import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/app_colors.dart';
import 'package:movie_app/core/enums/text_style_enum.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomModalBottomSheet({
    super.key,
    required this.title,
    required this.description,
    this.confirmButtonText,
    this.cancelButtonText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CustomTextWidget(
              text: title,
            ),
            const Spacer(),
            IconButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 30.r,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextWidget(
          text: description,
          textThemeStyle: TextThemeStyleEnum.displaySmall,
          maxLines: 9999999,
        ),
        const SizedBox(height: 20),
        confirmButtonText != null
            ? CustomButton(
                width: double.infinity,
                onPressed: onConfirm ?? () {},
                child: CustomTextWidget(
                  text: confirmButtonText!,
                  color: Get.theme.colorScheme.onSurface,
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        cancelButtonText != null
            ? CustomButton(
                backgroundColor: SharedColors.blueGreyColor,
                borderColor: Get.theme.colorScheme.primary,
                width: double.infinity,
                onPressed: onCancel ??
                    () {
                      Navigator.pop(context);
                    },
                child: CustomTextWidget(
                  text: cancelButtonText!,
                  color: Get.theme.colorScheme.primary,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
