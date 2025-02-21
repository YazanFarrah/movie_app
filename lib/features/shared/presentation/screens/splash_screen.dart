import 'dart:developer';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/asset_paths.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/core/enums/text_style_enum.dart';
import 'package:movie_app/core/routes/route_paths.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _localStorage = Get.find<HiveServices>();

  @override
  void initState() {
    checkUserState();
    super.initState();
  }

  void checkUserState() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchData();
    });
  }

  Future<void> fetchData() async {
    if (_localStorage.getToken == null) {
      log("Null token: ${_localStorage.getToken}");
      await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed(RoutePaths.signup);
      return;
    }
    log("token: ${_localStorage.getToken}");
    await Future.wait([
      Get.find<CurrentUserController>().getUser(),
      // usually I do multiple future operations here that's why I used future.wait
    ]).then((_) {
      Get.offAllNamed(RoutePaths.navScreen);
    }).onError((_, stackTrace) {
      log(stackTrace.toString());
      Get.offAllNamed(RoutePaths.signup);
      ToastUtils.showError("errorOccuredPleaseCloseTheAppAndTryAgain");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: SvgPicture.asset(AssetPaths.appLogo, width: 145.w)
                .animate()
                .shimmer(duration: 900.ms),
          ),
          SizedBox(height: 24.h),
          RepaintBoundary(
            child: CustomTextWidget(
              text: AppConstants.appName,
              textAlign: TextAlign.center,
              color: Get.theme.colorScheme.onSurface,
              textThemeStyle: TextThemeStyleEnum.displayLarge,
              isLocalize: false,
              fontSize: 24,
            ).animate().shimmer(duration: 900.ms),
          ),
          const SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}
