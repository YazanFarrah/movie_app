import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/asset_paths.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isNotification;
  final String placeholder;
  final bool? noPlaceHolder;
  final bool? noErrorHandler;
  final bool? largePlaceErrorScale;
  final bool asDecoration;

  // New attribute for elevation
  final double? elevation;

  // Decoration properties
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Color? backgroundColor;

  const CustomImage({
    super.key,
    required this.image,
    this.height = 28,
    this.width = 28,
    this.fit = BoxFit.contain,
    this.isNotification = false,
    this.placeholder = '',
    this.noPlaceHolder,
    this.noErrorHandler = false,
    this.largePlaceErrorScale,
    this.asDecoration = false,
    this.borderRadius,
    this.gradient,
    this.backgroundColor,
    this.elevation, // New attribute
  });

  @override
  Widget build(BuildContext context) {
    // Define the BoxShadow based on the elevation
    BoxShadow? boxShadow;
    if (elevation != null) {
      boxShadow = BoxShadow(
        color: Colors.black.withValues(alpha: 0.3),
        spreadRadius: elevation! / 2,
        blurRadius: elevation!,
        offset: Offset(0, elevation! / 2),
      );
    }

    return Container(
      height: height?.w,
      width: width?.w,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow] : null,
        gradient: gradient,
        color: backgroundColor,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            child: Image.network(
              image,
              fit: fit,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                } else {
                  final percentage = (progress.cumulativeBytesLoaded /
                          (progress.expectedTotalBytes ?? 1)) *
                      100;
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: height != null ? height! / 1.5 : height,
                          width: width != null ? width! / 1.5 : width,
                          decoration: BoxDecoration(
                            color: SharedColors.greyTextColor,
                            borderRadius: borderRadius,
                            boxShadow: boxShadow != null ? [boxShadow] : null,
                            gradient: gradient,
                          ),
                        ),
                        CircularProgressIndicator(
                          value: percentage / 100,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                log("Inside error builder: $error");
                return noErrorHandler == true
                    ? const SizedBox.shrink()
                    : SvgPicture.asset(AssetPaths.appLogo);
              },
            ),
          ),
          if (asDecoration)
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: gradient,
                color: backgroundColor,
              ),
            ),
        ],
      ),
    );
  }
}
