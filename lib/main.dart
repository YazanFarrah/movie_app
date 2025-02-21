import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/di.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await ScreenUtil.ensureScreenSize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  DependencyInjection.init();

  runApp(
    const App(),
  );
  FlutterNativeSplash.remove();
}
