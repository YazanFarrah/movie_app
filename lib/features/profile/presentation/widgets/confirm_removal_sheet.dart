import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';

class ConfirmRemovalSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  const ConfirmRemovalSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: "Remove from saved?",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.primary,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: CustomTextWidget(
                  text: "Cancel",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: CustomTextWidget(
                  text: "Remove",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
