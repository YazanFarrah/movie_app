import 'dart:async';
import 'dart:developer';
import 'package:movie_app/config/app_themes.dart';
import 'package:movie_app/core/routes/route_paths.dart';
import 'package:movie_app/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        Future.delayed(
          Duration.zero,
          () async {
            log("inactive app ");
          },
        );
        break;
      case AppLifecycleState.resumed:
        Future.delayed(
          Duration.zero,
          () {
            log("resume app");
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {});
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Future<void> dispose() async {
    Future.delayed(
      Duration.zero,
      () async {},
    );

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void openAppLink(Uri uri) {
    Get.toNamed(uri.fragment);
  }

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: RoutePaths.splashScreen,
          getPages: AppRouter.routes,
          debugShowCheckedModeBanner: false,
          title: 'Insurance App',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.light,
          builder: (context, child) {
            final Overlay overlay = Overlay(
              initialEntries: <OverlayEntry>[
                if (child != null)
                  OverlayEntry(
                    builder: (BuildContext ctx) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaler: const TextScaler.linear(1.0),
                        ),
                        child: child,
                      );
                    },
                  ),
              ],
            );
            return overlay;
          },
        );
      },
    );
  }
}
