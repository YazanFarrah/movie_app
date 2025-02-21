import 'package:movie_app/core/routes/route_paths.dart';
import 'package:movie_app/features/auth/bindings/auth_bindings.dart';
import 'package:movie_app/features/auth/presentation/screens/signup_screen.dart';

import 'package:movie_app/features/shared/presentation/screens/nav_bar.dart';
import 'package:get/get.dart';
import 'package:movie_app/features/shared/presentation/screens/splash_screen.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutePaths.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutePaths.navScreen,
      page: () => NavBar(),
    ),
    GetPage(
      name: RoutePaths.signup,
      page: () => SignupScreen(),
      binding: AuthBindings(),
    ),
  ];
}
